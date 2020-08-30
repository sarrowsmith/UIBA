#!/usr/bin/python3

import unicodedata
import sys

raw_charmap = set(sys.stdin.read().split())
charmap = set( int(c, 16) for c in raw_charmap if '-' not in c )
for r in raw_charmap:
    limits = r.split('-')
    if len(limits) != 2:
        continue
    charmap = charmap.union(range(int(limits[0], 16), int(limits[1], 16)+1))

for n in range(0x25AA, 0x2B56):
    if n not in charmap:
        continue
    a_chr = chr(n)
    try:
        adjective = unicodedata.name(a_chr)
    except ValueError:
        continue
    short = " %s " % adjective
    for never in ("BRAILLE",):
        short = short.replace(" %s " % never, "!")
    if short.count("!") > 0:
        continue
    for omit in ("WHITE", "BLACK", "CHESS", "SUIT", "DIE", "MUSIC",
        "MONOGRAM FOR", "DIGRAM FOR", "TRIGRAM FOR", "CROSS OF",
        "SYMBOL", "SIGN", "MARK", "CIRCLED", "ARROW", "ORNAMENT"):
        short = short.replace(" %s " % omit, " ")
    short = short.replace("  ", " ").replace(" -", " ").strip().strip("-")
    if len(short) > 30:
        continue
    print("adjective\t%s\t%s\t%s" % (a_chr, short.title(), adjective))

for n in range(0x1F004, 0x1FA95):
    if n not in charmap:
        continue
    n_chr = chr(n)
    try:
        noun = unicodedata.name(n_chr)
    except ValueError:
        continue
    short = " %s " % noun
    for never in ("SQUARED", "INDICATOR", "EMOJI", "INPUT"):
        short = short.replace(" %s " % never, "!")
    if short.count("!") > 0:
        continue
    for omit in ("BLACK", "WHITE", "SYMBOL", " SIGN", "INDEX",
        "CLOCK FACE", "ALCHEMICAL FOR", "CIRCLED", "IDEOGRAPH"):
        short = short.replace(" %s " % omit, " ")
    short = short.replace(" AND ", " & ").replace("  ", " ").replace(" -", " ").strip().strip("-")
    if len(short) > 30:
        continue
    print("noun\t%s\t%s\t%s" % (n_chr, short.title(), noun))
