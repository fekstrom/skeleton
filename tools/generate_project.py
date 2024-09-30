#! /usr/bin/env python3

import argparse
import re
import os
import shutil
import sys

def to_camel_case(name):
  return ''.join(w.capitalize() for w in to_snake_case(name).split('_'))

def to_snake_case(name):
  # stackoverflow.com/questions/1175208/elegant-python-function-to-convert-camelcase-to-snake-case
  return re.sub('((?<=[a-z0-9])[A-Z]|(?!^)(?<!_)[A-Z](?=[a-z]))', r'_\1', name).lower()

def to_upper_case(name):
  return to_snake_case(name).upper()

class OutputName:
  def __init__(self, name):
    self.camel_case = to_camel_case(name)
    self.snake_case = to_snake_case(name)
    self.upper_case = to_upper_case(name)

def remove_skips(src):
  src_lines = src.splitlines()
  dst_lines = []
  skip = False

  for line in src_lines:
    if "SKELETON_GENERATE_PROJECT_SKIP_BEGIN" in line:
      if skip:
        raise ValueError("Found SKIP_BEGIN while looking for SKIP_END")
      skip = True
    elif "SKELETON_GENERATE_PROJECT_SKIP_END" in line:
      if not skip:
        raise ValueError("Found SKIP_END without preceeding SKIP_BEGIN")
      skip = False
    elif not skip:
      dst_lines.append(line)

  if skip:
    raise ValueError("Reached end of file while looking for SKIP_END")

  return "\n".join(dst_lines)

def transform_text(src, output_name):
  return (
    remove_skips(src)
    .replace('Skeleton', output_name.camel_case)
    .replace('skeleton', output_name.snake_case)
    .replace('SKELETON', output_name.upper_case)
  )

def transform_path(src, output_name):
  return transform_text(src, output_name)

def transform_file(src, dst, output_name):
  with open(src) as f:
    try:
      intext = f.read()
    except Exception:
      print(f'could not read file: {src}', file=sys.stderr)
      raise
  outtext = transform_text(intext, output_name)
  os.makedirs(os.path.dirname(dst), exist_ok=True)
  with open(dst, 'w') as f:
    f.write(outtext)
  shutil.copymode(src, dst)

def create_skeleton(input_root, output_parent, output_name, force = False):
  input_root = os.path.abspath(input_root)
  output_root = os.path.abspath(os.path.join(output_parent, output_name.snake_case))
  if os.path.exists(output_root) and not force:
    print('The output root {} already exists. Use force to overwrite.'.format(output_root))
    return

  ignored_directories = [
    r'[.]git([^h]|$)', # Ignore .git but not .github
    r'__pycache__',
    r'[.]cache',
    r'[.]vscode',
    r'build',
    r'install',
    r'user_test',
  ]

  ignored_files = [
    r'CMakeUserPresets[.]json',
    r'core',
    r'generate_project[.]py',
  ]

  for dirpath, dirnames, filenames in os.walk(input_root):
    if any([re.search(i, dirpath) for i in ignored_directories]):
      continue
    for filename in filenames:
      src = os.path.join(dirpath, filename)
      if any([re.search(i, src) for i in ignored_files]):
        continue
      tmp = transform_path(os.path.relpath(dirpath, input_root), output_name)
      dst = os.path.join(output_root, tmp, transform_path(filename, output_name))
      transform_file(src, dst, output_name)

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('output_name', help='Name of the library to create, in snake_case or CamelCase.')
  parser.add_argument('--output_parent', default='.', help='Parent directory of the output root (defaults to .).')
  parser.add_argument('-f', '--force', action='store_true', help='Overwrite the output directory if it already exists.')
  args = parser.parse_args()

  input_root = os.path.dirname(os.path.dirname(sys.argv[0]))
  create_skeleton(input_root, args.output_parent, OutputName(args.output_name), args.force)
