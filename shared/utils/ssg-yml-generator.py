#!/usr/bin/env python

import os
import os.path
import re
import sys
import argparse
import datetime
import yaml


try:
    from xml.etree import cElementTree as ET
except ImportError:
    import cElementTree as ET

try:
    set
except NameError:
    # for python2
    from sets import Set as set


def get_node_key(node, key):
    try:
        key = node.attrib[key]
    except KeyError:
        key = ''

    return key


def get_mixed_text(tree, node):
    elem = tree.find(node)
    lines = (elem.text + ''.join(map(ET.tostring, elem))).strip()
    
    return lines.strip()


def generate_content_from_xml_file(xmlfile, filename, ftype, group):
    title = ''
    tree = ET.fromstring(xmlfile)

    rule_id = tree.attrib['id']
    severity = tree.attrib['severity']
    desc = get_mixed_text(tree, 'description')
    ocil_desc = get_mixed_text(tree, 'ocil')
 
    for node in tree:
        if node.tag == 'title':
            title = node.text
        if node.tag == 'ocil':
            clause = get_node_key(node, 'clause')
        if node.tag == 'rationale':
            rationale = node.text
        if node.tag == 'oval':
            oval = node.attrib['id']
            var = get_node_key(node, 'value')
        if node.tag == 'ident':
            cce = get_node_key(node, 'cce')
            stig = get_node_key(node, 'stig')
        if node.tag == 'ref':
            nist = get_node_key(node, 'nist')
            disa = get_node_key(node, 'disa')
        
    filename = os.path.splitext(filename)[0] + "." + ftype

    with open(filename, 'w') as f:
        f.write("---\ndocumentation_complete: true")
        f.write("\ntitle: %s" % title)
        f.write("\nrule_id: %s" % rule_id)
        f.write("\nprimary_group: %s" % group)
        f.write("\nseverity: %s" % severity)
        f.write("\n\ndescription: |")
        for line in desc.splitlines():
            f.write("\n    %s" % line)
        f.write("\n\nocil:")
        f.write("\n    clause: %s" % clause)
        f.write("\n    description: |")
        for line in ocil_desc.splitlines():
            f.write("\n        %s" % line)
        f.write("\n\nrationale: |")
        for line in rationale.splitlines():
            f.write("    %s\n" % line)
        f.write("\nidentifiers:")
        f.write("\n    cce: %s" % cce)
        f.write("\n    stig: %s" % stig)
        f.write("\n\nreferences:")
        f.write("\n    nist: %s" % nist)
        f.write("\n    disa: %s" % disa)


def read_xml_files(root, files, ftype, group):
    for filename in files:
        if filename.endswith(".xml"):
            with open(os.path.join(root, filename), "r") as content_file:
                content = content_file.read()
                tree = generate_content_from_xml_file(content, filename, ftype, group)


def read_content_in_dirs(ftype, group):
    path = os.path.dirname(os.path.realpath(__file__))
    for root, dirs, files in sorted(os.walk(path)):
        read_xml_files(root, files, ftype, group)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--group", action="store",
                         help="XCCDF Group each Rule corresponds to")
    parser.add_argument("--file_type", action="store",
                         default="rule", required=False,
                         help="File output typle [Default: .%(default)s]")
    parser.add_argument("files", metavar="FILES", nargs="+",
                         help="List of files")


    args, unknown = parser.parse_known_args()
    if unknown:
        sys.stderr.write(
            "Unknown arguments " + ",".join(unknown) + ".\n"
        )
        sys.exit(1)

    if len(sys.argv) < 3:
        parser.error(parser.print_help())
    
    if not args.group:
        parser.error(parser.print_help())

    if not args.files:
        read_content_in_dirs(args.file_type, args.group)
    else:
        read_xml_files('', args.files, args.file_type, args.group)


if __name__ == "__main__":
    main()
