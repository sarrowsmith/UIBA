#!/usr/bin/python3

import unicodedata

for n in range(0x2648, 0x2654):
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

for n in range(0x1F300, 0x1F322):
    n_chr = chr(n)
    try:
        noun = unicodedata.name(n_chr)
    except ValueError:
        continue
    short = " %s " % noun
    for never in ("EMOJI", "INPUT",
        "CHESS", "XIANGQI"): # No glyphs for these in Noto font
        short = short.replace(" %s " % never, "!")
    if short.count("!") > 0:
        continue
    for omit in ("BLACK", "WHITE", "SYMBOL", " SIGN", "INDEX",
        "CLOCK FACE", "ALCHEMICAL FOR"):
        short = short.replace(" %s " % omit, " ")
    short = short.replace(" AND ", " & ").replace("  ", " ").replace(" -", " ").strip().strip("-")
    if len(short) > 30:
        continue
    print("noun\t%s\t%s\t%s" % (n_chr, short.title(), noun))
