#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright (c) 2009, Bryan Davis
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#   * Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#   * Neither the name of the <ORGANIZATION> nor the names of its
#     contributors may be used to endorse or promote products derived
#     from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
# USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGE.
#
# $Id: apachelog.py 368 2011-04-04 21:34:50Z bpd $

"""
Simple apache combined log file parser. Useful for extracting interesting
fields from the mass of log data.
"""

import re

COMMON = r'(\S+) (\S+) (\S+) \[([^\]]*)\] "(\S+) (\S+) (\S+)" (\S+) (\S+)'
RE_COMMON = re.compile(COMMON)
LABELS_COMMON = (
    'host','identd','user','datetime', 'method', 
    'request', 'proto', 'status', 'bytes',
)

COMBINED = r'%s "([^"]*)" "([^"]*)"' % COMMON
RE_COMBINED = re.compile(COMBINED)
LABELS_COMBINED = LABELS_COMMON + ('referrer', 'useragent')

def field_map (dictseq, name, func):
  """
  Process a sequence of dictionaries and remap one of the fields

  Args:
    dictseq: Sequence of dictionaries
    name: Field to modify
    func: Modification to apply
  """
  for d in dictseq:
    d[name] = func(d[name])
    yield d
#end field_map

def apache_log (lines, logpat=RE_COMBINED, labels=LABELS_COMBINED):
  """
  Parse an apache log file into a sequence of dictionaries

  Args:
    lines: line generator
    logpat: regex to split lines
    labels: names for fields resulting from regex match

  Returns:
    generator of mapped lines
  """
  groups = (logpat.match(line) for line in lines)
  tuples = (g.groups() for g in groups if g)
  log = (dict(zip(labels, t)) for t in tuples)
  log = field_map(log, 'status', int)
  log = field_map(log, 'bytes', lambda s: int(s) if s != '-' else 0)
  return log
#end apache_log

def print_fields (log, fields):
  """
  Print selected fields from an apache log.

  Args:
    log: log generator
    fields: list of fields to print
  """
  for l in log:
    for f in fields:
      if f in l:
        print "%s" % l[f] ,
      else:
        print "?" ,
    print
#end print_fields

if __name__ == '__main__':
  import optparse
  parser = optparse.OptionParser(usage="usage: %prog [options] < apache.log",
      version="%prog $Revision: 368 $")
  parser.add_option("-f", "--fields", dest="fields", 
      help="list of fields to display: %s" % ', '.join(LABELS_COMBINED),
      metavar="FIELD1,FIELD2,...",
      default=','.join(LABELS_COMBINED))
  parser.add_option("-x", "--combined", 
      action="store_true", dest="combined",
      help="Parse a combined format log [default]", default=True)
  parser.add_option("-c", "--common", 
      action="store_false", dest="combined",
      help="Parse a common format log")
  (options, args) = parser.parse_args()

  import sys
  if options.combined:
    log = apache_log(sys.stdin)
  else:
    log = apache_log(sys.stdin, RE_COMMON, LABELS_COMMON)

  print_fields(log, options.fields.split(','))
