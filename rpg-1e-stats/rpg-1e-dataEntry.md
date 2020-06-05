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

---

### Key

A lower-case, snake-case string that serves as the key to look
up the monster. Usually a literal copy of the monster listing.
For instance, MM1's `Ant, Giant` becomes `ant_giant`.

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
on page 175. That is the level of the monster.

---

### XP

For MM1 monsters, refer to DMG p. 196 and beyond. To format, use
the small-spaced plus, e.g. `40\+3/hp`.

