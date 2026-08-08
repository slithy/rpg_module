# 1e Data Entry

Monster entries vary widely across the DMG, MM1, FF, and MM2. Here
are guidelines on how to handle each of the columns.

## General Tips

1. Sometimes a monster is described as having a range of HDs, hit
    points, or AC's. In these cases, it is best to create a summary
    entry that closely follows the entry in the manual, and then
    derive additional entries, one for each specific AC/HD
    combination, keyed by HD. For instance, the `Anhkheg` has
    an HD range of 3-8, so entries were created for `anhkheg_3hd`,
    `anhkheg_4hd`, etc.
2. Ranges should be specified with two individual dashes, like `13--16`
3. When slashes can appropriately be line-breaked, use `\?` instead of 
    `/`. For example in damages, `1--3\?1--3\?2--6`.
4. For a non-breaking space, use `\,`
5. When inputting data don't use smart or escaped single quotes or 
    double quotes.
6. Read introductory material that applies to an entire monster group,
    not only the individual stat block. Dragon ages and abilities, giant
    rock throwing, and similar shared rules can change several fields.
7. Add every new MM1 monster record to both `mm.csv` and
    `mm-xp-audit.csv` in the same change. This includes summary records,
    aliases, and keyed HD or ability variants; each CSV key should have a
    corresponding XP-tracking row explaining the selected p. 85 row and
    ability awards.

## Sources and Precedence

Use the sources for different purposes rather than treating any one of
them as uniformly authoritative:

1. Use the full monster entry in MM1, FF, or MM2 for the monster's actual
    statistics and abilities. Include abilities stated in the prose even
    when they are absent from the summary lines.
2. Use the DMG Appendix E listing for THAC0 and as the starting point for
    XP, but check both against the monster's actual HD and description.
    Appendix E contains transcription, row-selection, and arithmetic
    errors; a blank or abbreviated field there does not override the full
    monster entry.
3. Use the Experience Points Value of Monsters table on DMG p. 85 to
    reconstruct and validate XP. Its category definitions and explicit
    examples take precedence over an Appendix E value that contradicts
    them.
4. Use *Dismembering the Monster Manual* as an audit aid. It is useful for
    finding likely ability counts, crossed values, and wrong HD rows, but
    verify its assumptions against the primary books.
5. Do not use publication order alone to resolve a disagreement. Prefer
    the source that actually defines the statistic, and use internal
    consistency to identify obvious typographical errors.

---

### Key

A lower-case, snake-case string that serves as the key to look
up the monster. Usually a literal copy of the monster listing.
For instance, MM1's `Ant, Giant` becomes `ant_giant`.

Keep separate records when two useful lookup keys refer to the same
statistics. Such aliases are intentional when either name is likely to be
used by a module author, even if the resulting records are otherwise
identical.

---

### Singular

The friendly, singular form of the monster name. For instance,
`Giant Ant`.

---

### Plural

Usually optional, as it can be derived by putting an 's' on the end.
In the cases where this doesn't work, specify the plural form. For
instance, `Cattle` as plural form for `Cattle`.

---

### Category

For when monsters are to be grouped. In the DMG, grouped
monsters are indented, and in the MM1, they are in columnar
format within one monster entry. For instance, `Crocodile`
and `Demon`.

---

### THACO

These are not included in MM1, but they are in the DMG. When
there are multiple consecutive possible THAC0s, a range is 
preferred, e.g. `13--16`. Otherwise, escaped slashes are 
acceptable, e.g. `19\?16\?15`.

Validate the DMG value against the monster's HD or an explicit "attacks
as" statement. "Attacks as N HD" changes THAC0 and related combat
performance; it does not by itself change the monster's HD for XP.

Do not copy a `20` from Appendix E's "To Hit A.C. 0" column without
checking the attack matrix. Rows with repeated or "sticky" 20s can have
a different extrapolated THAC0. Derive it from the surrounding armor
classes: for example, a sub-1-HD creature that needs 14 to hit AC 7 has
THAC0 21, even though its matrix entry against AC 0 is 20.

Keep explicit bonuses or penalties to the "to hit" die separate from
THAC0. THAC0 records the unmodified attack-matrix value; apply the
modifier to the d20 roll and record it in the appropriate attack or
special field. Do not bake it into THAC0: the repeated-20 portion of the
matrix is non-linear, and doing so would also double-count a modifier
already recorded elsewhere.

---

### AC

A width-constrained column. Usually should be one number, but
in the cases of monsters with multiple AC's, pick a "main" AC,
a non-breaking space, and other ACs in parentheses. For instance,
`0\,(2,7)`.

---

### MV

Use the literal MM1 convention here, with literal slashes.
For instance, `6"//12"`

---

### HD

For HD pluses, don't use spaces - i.e. use `4+3` instead of 
`4 + 3` or `4\+ 3`.  For fractional HDs, favor LaTeX fractions 
instead of hp descriptions, like `\sfrac{1}{8}` instead of
`1 hit point`.

Keep fixed hit points from the prose on leader and other variant records,
but do not infer a new XP bracket merely because the variant attacks as a
higher-HD creature.

---

### #AT

---

### Damage (long)

Always use breaking slashes in this section, in case a line
break is needed.

---

### Damage (short)

Rather than following MM/DMG convention here, try to take
shortcuts to compress the damage information into fewer 
characters.

---

### SA

---

### SD

---

### MR

---

### Special

This is supposed to be a combination of the `SA` and `SD` fields
above, but it can be abbreviated and compressed to save space.
Always separate the SA and SD sections with a semicolon. For tips,
compare the MM1 entries with the DMG; the DMG often has a shorter
convention.

If the SA or SD fields mention psionics or magic resistance, it 
is still a good idea to include them here because the normal 
psionic or MR columns are not included in every output format.

---

### Size

---

### Int

---

### Alignment

Use the spelled-out alignment, following common convention.
For monsters with multiple alignments, use the most common 
alignment or `Neutral`, rather than listing multiple alignments.

---

### Psionic

---

### Attack/Defense Modes

---

### Frequency

---

### No. Appearing

---

### % in Lair

Make sure to escape the percentage sign, e.g. `85\%` 

---

### Treasure Type

---

### Level

For MM1 monsters, while this is not explicitly listed in the DMG, it 
can be derived. Look at the raw subtotal of XP that the DMG mentions.
This is the subtotal of base + special abilities + exceptional
abilities, before hit points. Look up that subtotal in the table
on page 174. That is the level of the monster.

The random encounter tables are a useful cross-check on intended monster
level, especially when an XP value is malformed, but they do not replace
the p. 85 calculation.

---

### XP

For MM1 monsters, refer to DMG p. 196 and beyond. To format, use
the small-spaced plus, e.g. `40\+3/hp`.

Appendix E values must be checked against the table on DMG p. 85. Use:

```
BXP + (number of S x SAXPB) + (number of E x EAXPA) + (hp x XP/HP)
```

The CSV value before `\+N/hp` is the subtotal of BXP and all ability
awards. `N` is the XP/HP value from the same HD row. If Appendix E gives a
fixed-hp monster a fixed XP total, verify that the total includes the
correct XP/HP component before preserving it. Do not convert to a fixed
total merely because a leader or other variant has fixed hit points; such
a variant can retain the parent monster's XP formula.

Apply these row boundaries literally:

- Exactly `1-1` HD uses the `1-1 to 1` row, not `up to 1-1`.
- An exact integer HD uses the row that ends at that integer. For example,
  7 HD uses `6+1 to 7`.
- Any positive hit-point addition after an integer uses the following
  row. For example, 3+3 HD uses `3+1 to 4`.
- For a monster with stated HD, select the row from actual HD, not THAC0,
  monster level, or an "attacks as" statement.

Fixed-hit-point monsters require a separate inference because the rules do
not provide a general conversion from fixed hit points to HD for XP. Preserve
the literal hit-point value in the HD field, and infer the p. 85 row from the
whole record:

- When Appendix E supplies a plausible XP formula for a fixed-hit-point
  leader or variant, do not replace its row solely because the fixed hit
  points resemble a different number of dice or the variant attacks as a
  higher-HD creature. Preserve the Appendix row unless independent evidence
  demonstrates an error. Orc chiefs and bodyguards therefore retain
  `20+2/hp`: their 13--16 hit points make their actual awards higher than the
  11-hit-point subchief and guard even though the formula is the same.

- Follow an explicit monster-specific conversion when the MM supplies one.
  The Golem introduction directs the referee to divide hit points by 4.5 and
  round up, yielding 9 HD for Flesh, 11 for Clay, 14 for Stone, and 18 for
  Iron Golems. This is a rule for golems, not a general fixed-HP rule.
- Dividing by 4.5, the average of a d8, is a useful plausibility check, not a
  rule. Likewise, do not infer HD by dividing by the maximum 8 hp per die or
  rounding that quotient up.
- Cross-check the plausible HD range against THAC0, comparable monsters, the
  XP/HP rate, and whether the published total reverse-engineers into
  non-negative whole-number Special and Exceptional award units.
- Exact arithmetic can justify an adjacent row when the other evidence is
  coherent. Record the reason for such exceptions; Juiblex is an example,
  because the 21-and-up row exactly reproduces the published total with a
  balanced allocation despite 88 hp being close to the average for 20 HD.
- Do not select a less plausible row merely because it is the only way to
  reproduce a suspect published total. Reconstruct the award from the most
  defensible row and the described abilities. For example, Geryon's 133 hp is
  roughly the average for 30 d8 HD, supporting the 21-and-up row rather than
  17--18+.

Audit the subtotal and the XP/HP value separately. A published subtotal
can reverse-engineer cleanly while its per-hit-point value comes from the
wrong row. Conversely, values for adjacent monsters can be crossed even
when both numbers are individually valid.

Every ability award should map to a combat-relevant feature in the full
monster description. Use the p. 85 categories consistently:

- Special abilities include four or more attacks, missile discharge,
  armor class 0 or lower, ordinary special attacks and defenses, being
  hit only by special or magical weapons, combat-relevant high
  intelligence, and minor spell-like defenses.
- Exceptional abilities include energy drain, paralysis, poison, major
  breath weapons, magic resistance, spell use, swallowing whole,
  weakness, and the listed maximum-damage thresholds.
- For a maximum-damage award, total the attacks in one normal attack
  routine that can be directed at a single opponent. For one, two, three,
  or four or more attacks, award an exceptional ability only when the
  combined maximum is greater than 24, 30, 36, or 42, respectively. Do
  not include attacks that must be distributed among other opponents.
- Treat a material saving-throw bonus, elemental immunity or resistance,
  improved surprise chance, or a reliable prose-only combat ability as
  an award when it fits one of those categories.
- Do not award intelligence merely because its rating is high; it must
  affect combat.
- Classify the same ability consistently across closely related forms even
  when Appendix E implies different categories. For the Otyugh family,
  disease is one Exceptional ability and never being surprised is one
  Special ability; the Neo-Otyugh adds one Special for AC 0.

Ability awards are cumulative. The p. 85 rule for an extraordinary power
can multiply an individual ability award or a clearly related package by
2, 4, 8, 10, or more. Preserve the ordinary BXP and XP/HP components when
using a multiplier. First identify the underlying S and E abilities, then
apply the multiplier; do not invent fractional or negative ability counts
merely to reproduce a published total.

If Appendix E cannot be expressed as a non-negative whole-number
combination of the selected row's BXP, SAXPB, and EAXPA, treat that as
evidence of an error. Reconstruct the value from the monster description
and p. 85 rather than copying it unchanged.

For a monster with a range of HD, retain the summary record and add a
record for each specific form. Calculate each specific form from its own
HD row. When a single XP and level are required for the summary record,
use the representative middle form rather than the lowest or highest
form. Add separately described leaders, guards, or named subtypes when
their AC, THAC0, hit points, attacks, or damage differ, even when their XP
formula remains the same.
