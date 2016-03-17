%% module.cls
%
% An Adventure Module class for LaTeX
%
% Copyright 2016 Michael C. Davis
%
% LICENSE FOR THE WORK
%
% This work consists of the following files:
%    module.cls
%    basic_stats.sty
%    module.tex
%
% This work may be distributed and/or modified under the conditions of the LaTeX
% Project Public License, either version 1.3 of this license or (at your option)
% any later version. The latest version of this license can be found at:
% http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `author-maintained'.
% 
% The Author and Maintainer of this work is Michael C. Davis
%
%
% LICENSE FOR COMPILED WORKS
%
% You may distribute compiled works generated using the work as specified in
% Clause 3 of the LaTeX Project Public License. If you incorporate Open Gaming
% Content into the compiled work, you must also comply with the terms of that
% license.
%
%
% USAGE
%
% See the file module.tex for an example of how to use this class.

% TO DO
%
% 3. Move stat blocks into a separate .sty file, keep OGL content separate from other text
% 4. Add all monsters into stat blocks
% 3. wandering monster chart
% 4. Have separate commands for inline stat blocks and new monster stat blocks. The inline one should detect if it is inside the table environment and format itself appropriately.
% 5. Monster stat blocks : inline, table or full text for appendix
% 6. Stat block hit points should be an optional argument, tables can be defined with or without a hit point column.
% 7. Have option for Holmes AC, descending AC or ascending AC with descending AC as default
%
% 8. Set language to US or UK from paper size with option to override to any arbitrary language. Import text for stat blocks from a language-specific include file.
% 9. Perhaps allow system-dependent stat blocks... maybe going too far but at least think of how this could be accomplished and design in a way that allows the possibility in future. Stat blocks could be defined as system-specific as well as language specific.
%
% 10. Free to use but have a PayPal option for donations in case of commercial use...
% 11. Host it online (CTAN? git?). Set up a ticketing system for bugs and/or improvements

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{module}[2016/03/16 Adventure Module document class]



% Process class options

\newcounter{papersizeoption}
\newif\ifmodule@letterpaper

\newcounter{fontoption}
\newif\ifmodule@seriffont

\DeclareOption{letterpaper}{\module@letterpapertrue\stepcounter{papersizeoption}}
\DeclareOption{a4paper}{\module@letterpaperfalse\stepcounter{papersizeoption}}

\DeclareOption{serif}{\module@seriffonttrue\stepcounter{fontoption}}
\DeclareOption{sansserif}{\module@seriffontfalse\stepcounter{fontoption}}

\DeclareOption*{
   \PackageError{dnd_module}{Unrecognised option '\CurrentOption'}{Valid options are a4paper,letterpaper,serif,sansserif}
}

\ExecuteOptions{a4paper}                                                           % default paper size is A4
\ExecuteOptions{sansserif}                                                         % default font option is sans serif

\ProcessOptions\relax

\ifcase\thepapersizeoption\or\or\else
   \PackageError{module}{a4paper and letterpaper options are mutually exclusive}
   {The input file contains a statement like documentclass[letterpaper,a4paper]{module}.
    You can only select one paper size, either letterpaper or a4paper. The default is a4paper.}
\fi

\ifcase\thefontoption\or\or\else
   \PackageError{module}{serif and sanserif options are mutually exclusive}
   {The input file contains a statement like documentclass[serif,sansserif]{module}.
    You can only select one font style, either serif or sans serif. The default is sans serif.}
\fi



% Process paper size options

\setlength\voffset{-1in}
\setlength\hoffset{-1in}

\ifmodule@letterpaper
   \PassOptionsToClass{letterpaper}{article}
   \addtolength\voffset{-17.6mm}
   \addtolength\hoffset{2.95mm}
\else
   \PassOptionsToClass{a4paper}{article}
\fi



% Load article, the standard LaTeX document class that module is based on

\LoadClass[twocolumn]{article}



% Set page margins

\setlength{\oddsidemargin}{1cm}
\setlength{\evensidemargin}{1cm}

\setlength{\topmargin}{2.6cm}
\setlength{\headheight}{0cm}
\setlength{\headsep}{0cm}

\setlength{\textheight}{25.4cm}
\setlength{\textwidth}{19cm}

\setlength{\marginparsep}{0cm}
\setlength{\marginparwidth}{0cm}

\setlength{\footskip}{0.7cm}

\pagenumbering{arabic}



% Process font options

\RequirePackage[T1]{fontenc}                                                       % Use T1 (8-bit) font encoding

\ifmodule@seriffont
   \IfFileExists{souvenir.sty}{                                                    % If ITC Souvenir font is installed in this LaTeX distribution
      \RequirePackage{souvenir}                                                    % Use ITC Souvenir as serifed font
      \renewcommand{\bfdefault}{d}                                                 % Use demi-bold instead of bold
      \renewcommand*\copyright{{\usefont{T1}{lmr}{m}{n}\textcopyright}}            % Get a good-looking copyright symbol
   }{
      \PackageWarning{module}{%
         ITC Souvenir not detected, substituting Bookman as default serifed font.}
      \RequirePackage{bookman}                                                     % Use Bookman as serifed font
   }
   \renewcommand*\familydefault{\rmdefault}                                        % Default to serifed font
\else
   \RequirePackage{avant}                                                          % Use URW Gothic as default sans-serif font (similar to ITC Avant Garde Gothic)
   \renewcommand*\familydefault{\sfdefault}                                        % Default to sans-serif font
\fi

\renewcommand{\tiny}        {\fontsize {4pt} {4.8pt}\selectfont}
\renewcommand{\scriptsize}  {\fontsize {5pt} {6.0pt}\selectfont}
\renewcommand{\footnotesize}{\fontsize {7pt} {8.4pt}\selectfont}
\renewcommand{\small}       {\fontsize {8pt} {9.6pt}\selectfont}
\renewcommand{\normalsize}  {\fontsize {9pt}{10.8pt}\selectfont}
\renewcommand{\large}       {\fontsize{10pt}{12.0pt}\selectfont}
\renewcommand{\Large}       {\fontsize{11pt}{13.2pt}\selectfont}
\renewcommand{\LARGE}       {\fontsize{13pt}{15.6pt}\selectfont}
\renewcommand{\huge}        {\fontsize{16pt}{19.2pt}\selectfont}
\renewcommand{\Huge}        {\fontsize{17.28pt}{20.74pt}\selectfont}



% Required packages

\RequirePackage[pass,paperwidth=\paperwidth,paperheight=\paperheight]{geometry}    % Page size
\RequirePackage[explicit,newparttoc]{titlesec}                                     % Redefine section headings
\RequirePackage{titletoc}                                                          % Redefine table of contents
\RequirePackage{array}                                                             % Format table headings
\RequirePackage{booktabs}                                                          % Underline table headings
\RequirePackage{framed}                                                            % For boxed text
\RequirePackage{graphicx}                                                          % Allow images and text across two columns
\RequirePackage{dblfloatfix}                                                       % Allow positioning of figure* at bottom of page
\RequirePackage{xstring}                                                           % Manipulate strings

% Hyperlinks

\RequirePackage[linktocpage=true]{hyperref}                                        % Allow hyperlinks, only page numbers in TOC are clickable
\RequirePackage[dvipsnames]{xcolor}                                                % Pre-defined colour names
\hypersetup{colorlinks=true,
    urlcolor=MidnightBlue,                                                         % Colour for external links
    linkcolor=MidnightBlue,                                                        % Colour for internal links (including Table of Contents)
    citecolor=MidnightBlue}                                                        % Colour for references

% Stat blocks

\RequirePackage{pgfkeys}
\input{pgfutil-common}
\input{pgfmath.code}

% The freestyle (system-independent) stat block

\newenvironment{statblockfreestyle}{\begin{list}{}{\leftmargin=1em\rightmargin=1em}\item}{\end{list}}

% Armour class macros

%\newcommand{\descac}{7}
%\pgfmathtruncatemacro{\ascac}{19-\descac}
%\newcommand{\holmesac}{\descac[\ascac]}

% Counter for setting up key-value pairs

\newcounter{currentstat}

% Define monsters

\newcommand{\monster}[4][default]{
   \pgfkeys{/#2/SingleName/.initial = {#3}}
      \ifnum\pdfstrcmp{#1}{default}=\z@
      \IfEndWith{#3}{y}
      {\pgfkeys{/#2/PluralName/.initial = \StrGobbleRight{#3}{1}ies}}     % Plural names ending in -y change to -ies
      {
         \IfEndWith{#3}{s}
         {\pgfkeys{/#2/PluralName/.initial = #3es}}                       % Plural names ending in -s change to -ses
         {\pgfkeys{/#2/PluralName/.initial = #3s}}                        % Default case, plurals where we add -s
      }
   \else
      \pgfkeys{/#2/PluralName/.initial = #1}                              % Override for irregular plurals
   \fi
   \setcounter{currentstat}{0}
   \def\currentmonster{#2}
   \scan@stats#4|\relax|
}

% Load system-specific stat blocks

\input{basic_stats.sty}

% Title Page

\renewcommand\maketitle{\hypersetup{pageanchor=false}% No internal links to title page allowed
\begin{titlepage}
\vspace*{\fill}
\begin{center}
\Huge \textbf{\@title} \par
\vskip 0.5em
\LARGE \textbf{by \@author}
\@subtitle
\@coverimg
\end{center}
\@abstract
\@copyright
\@contact
\vfill
\end{titlepage}
\hypersetup{pageanchor=true}
\global\let\maketitle\relax
\global\let\@author\@empty
\global\let\@subtitle\@empty
\global\let\@coverimg\@empty
\global\let\@abstract\@empty
\global\let\@copyright\@empty
\global\let\@contact\@empty
\global\let\title\relax
\global\let\author\relax
}

\newcommand\showtitle[1][\@title]{\begin{center}
\LARGE\textbf{#1}
\end{center}
\let\if@afterindentfalse}

\def\@subtitle{\relax}
\def\@coverimg{\relax}
\def\@abstract{\relax}
\def\@copyright{\relax}
\def\@contact{\relax}

\newcommand{\subtitle}[1]{\gdef\@subtitle{\vskip 0.5em \LARGE \textbf{\MakeUppercase{#1}}}}
\newcommand{\coverimage}[1]{\gdef\@coverimg{\vskip 1em \includegraphics[width=\textwidth]{#1} \par}}
\renewcommand{\abstract}[1]{\gdef\@abstract{\vskip 0.5em #1 \par}}

\newcommand{\copyrightblock}[1]{\gdef\@copyright{\vskip 0.5em
\begin{quote}
\centering
#1
\end{quote}}}

\newcommand{\contactblock}[4][p{5.9cm} p{5.9cm} p{5.9cm}]{\gdef\@contact{\vskip 0.5em
\begin{tabular}{#1}
{#2} & {#3} & {#4}
\end{tabular}
}}



% Headings

\renewcommand\thepart{\arabic{part}}
\renewcommand\thesection{}
\renewcommand\thesubsection{\arabic{subsection}}

\titleformat{\part}[block]
{\LARGE\filcenter\bfseries}
{\LARGE PART \thepart:}{0.5em}{\MakeUppercase{#1}}

\titleformat{\section}[hang]
{\Large\bfseries}
{}{0em}{\MakeUppercase{#1}}

\titleformat{name=\section,numberless}[block]                                         % how to handle \section*
{\Large\filcenter\bfseries}
{}{0em}{#1\phantomsection\addcontentsline{toc}{section}{#1}}

\titleformat{\subsection}[hang]
{\normalfont\bfseries}
{\thesubsection.}{0.5em}{\MakeUppercase{#1}}

\renewcommand{\subsubsection}{\relax}                                                 % The lowest defined section type is subsection



% Table of Contents

\renewcommand\tableofcontents{%
   \noindent\Large\textbf{\MakeUppercase\contentsname}\vspace{1em}\@starttoc{toc}
}

\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}
\titlecontents{part}[0em]{\normalsize\bfseries}{PART \thecontentslabel : \MakeUppercase}{}{\quad\thecontentspage}[\vspace{0.5em}]
\titlecontents*{section}[0em]{\normalsize}{}{}{~\thecontentspage}[\unskip, ][.\vspace{0.5em}]



% Boxed text

\newcommand{\boxtext}[1]{
\begin{framed}
\noindent #1
\end{framed}}



% Tables

\newcolumntype{b}{>{\bfseries}c}                                                      % New column type 'b' for bold, centred headings
\newcounter{numcols@module}                                                           % Counter to keep track of how many columns are in the table
\renewcommand{\arraystretch}{1.2}                                                     % Increase the table row spacing a little

% Underline table headers

\newtoks\module@tableul
\newcommand{\tableul}[1]{%
  \noalign{%
    \global\module@tableul={}%
    \toks@={\cmidrule(l{\tabcolsep}r{\tabcolsep})}%
    \count@=\z@
    \loop\ifnum\count@<#1\relax
      \advance\count@\@ne
      \edef\module@temp{\the\toks@{\the\count@-\the\count@}}%
      \global\module@tableul\expandafter{\the\expandafter\module@tableul\module@temp}%
    \repeat
  }%
  \the\module@tableul
}

% Typeset the table heading
% Takes a column type as an optional argument (defaults to 'c' for centred text)

\newcommand\tableheader[2][c]{{%
   \edef\lbracetoken{\string{}
   \edef\rbracetoken{\string}}
   \StrCount{#2}{&}[\numamps]\global\setcounter{numcols@module}{\numamps}\stepcounter{numcols@module}
   \def\source{\string\multicolumn\lbracetoken 1\rbracetoken\lbracetoken#1\rbracetoken\lbracetoken#2\rbracetoken}
   \def\replace{\rbracetoken&\string\multicolumn\lbracetoken 1\rbracetoken\lbracetoken#1\rbracetoken\lbracetoken}
   \StrSubstitute{\source}{ & }{\replace}[\tmptblhdr]
   \StrExpand{\tmptblhdr}{\tmptblhdrexpand}
   \tokenize{\tmptbltok}{\tmptblhdr}
   \global\let\tableheader@module\tmptbltok
}\\[-2ex] % hack to get around the fact that it's not allowed to have non-expandable text in the same cell as \multicolumn
\tableheader@module\\
\tableul{\thenumcols@module}
}



% Define a minipage the full width of a page. It takes the usual LaTeX float position arguments.

\newenvironment{wideminipage}[1][t]{%
   \begin{figure*}[#1]
   \begin{minipage}{\textwidth}
}{%
   \end{minipage}
   \end{figure*}
}



% Copyright and license macros

\newcommand{\modulecopyright}{%
The \LaTeX~module class is copyright \copyright 2016 Michael Davis. It can be distributed and/or modified under the conditions of the
\href{http://www.latex-project.org/lppl.txt}{LaTeX Project Public License}, either version 1.3 or (at your option) any later version. You
have the right to distribute Compiled Works generated using the module class as specified in Clause 3 of the license.}

\newenvironment{ogl}{%
\footnotesize
\subsection*{OPEN GAME LICENSE Version 1.0a}
The following text is the property of Wizards of the Coast, Inc. and is Copyright 2000 Wizards of the Coast, Inc (``Wizards''). All Rights Reserved.
\begin{enumerate}
\item Definitions: (a) ``Contributors'' means the copyright and/or trademark owners who have contributed Open Game Content; (b) ``Derivative Material''
means copyrighted material including derivative works and translations (including into other computer languages), potation, modification, correction,
addition, extension, upgrade, improvement, compilation, abridgment or other form in which an existing work may be recast, transformed or adapted; (c)
``Distribute'' means to reproduce, license, rent, lease, sell, broadcast, publicly display, transmit or otherwise distribute; (d) ``Open Game Content''
means the game mechanic and includes the methods, procedures, processes and routines to the extent such content does not embody the Product Identity
and is an enhancement over the prior art and any additional content clearly identified as Open Game Content by the Contributor, and means any work
covered by this License, including translations and derivative works under copyright law, but specifically excludes Product Identity. (e) ``Product
Identity'' means product and product line names, logos and identifying marks including trade dress; artifacts; creatures characters; stories,
storylines, plots, thematic elements, dialogue, incidents, language, artwork, symbols, designs, depictions, likenesses, formats, poses, concepts,
themes and graphic, photographic and other visual or audio representations; names and descriptions of characters, spells, enchantments, personalities,
teams, personas, likenesses and special abilities; places, locations, environments, creatures, equipment, magical or supernatural abilities or effects,
logos, symbols, or graphic designs; and any other trademark or registered trademark clearly identified as Product identity by the owner of the Product
Identity, and which specifically excludes the Open Game Content; (f) ``Trademark'' means the logos, names, mark, sign, motto, designs that are used by
a Contributor to identify itself or its products or the associated products contributed to the Open Game License by the Contributor (g) ``Use'',
``Used'' or ``Using'' means to use, Distribute, copy, edit, format, modify, translate and otherwise create Derivative Material of Open Game Content.
(h) ``You'' or ``Your'' means the licensee in terms of this agreement.

\item The License: This License applies to any Open Game Content that contains a notice indicating that the Open Game Content may only be Used under and
in terms of this License. You must affix such a notice to any Open Game Content that you Use. No terms may be added to or subtracted from this License
except as described by the License itself. No other terms or conditions may be applied to any Open Game Content distributed using this License.

\item Offer and Acceptance: By Using the Open Game Content You indicate Your acceptance of the terms of this License.

\item Grant and Consideration: In consideration for agreeing to use this License, the Contributors grant You a perpetual, worldwide, royalty-free,
non-exclusive license with the exact terms of this License to Use, the Open Game Content.

\item Representation of Authority to Contribute: If You are contributing original material as Open Game Content, You represent that Your Contributions are
Your original creation and/or You have sufficient rights to grant the rights conveyed by this License.

\item Notice of License Copyright: You must update the COPYRIGHT NOTICE portion of this License to include the exact text of the COPYRIGHT NOTICE of any
Open Game Content You are copying, modifying or distributing, and You must add the title, the copyright date, and the copyright holder's name to the
COPYRIGHT NOTICE of any original Open Game Content you Distribute.

\item Use of Product Identity: You agree not to Use any Product Identity, including as an indication as to compatibility, except as expressly licensed in
another, independent Agreement with the owner of each element of that Product Identity. You agree not to indicate compatibility or co-adaptability with any
Trademark or Registered Trademark in conjunction with a work containing Open Game Content except as expressly licensed in another, independent Agreement with
the owner of such Trademark or Registered Trademark. The use of any Product Identity in Open Game Content does not constitute a challenge to the ownership of
that Product Identity. The owner of any Product Identity used in Open Game Content shall retain all rights, title and interest in and to that Product Identity.

\item Identification: If you distribute Open Game Content You must clearly indicate which portions of the work that you are distributing are Open Game Content.

\item Updating the License: Wizards or its designated Agents may publish updated versions of this License. You may use any authorized version of this License
to copy, modify and distribute any Open Game Content originally distributed under any version of this License.

\item Copy of this License: You MUST include a copy of this License with every copy of the Open Game Content You Distribute.

\item Use of Contributor Credits: You may not market or advertise the Open Game Content using the name of any Contributor unless You have written permission
from the Contributor to do so.

\item Inability to Comply: If it is impossible for You to comply with any of the terms of this License with respect to some or all of the Open Game Content
due to statute, judicial order, or governmental regulation then You may not Use any Open Game Material so affected.

\item Termination: This License will terminate automatically if You fail to comply with all terms herein and fail to cure such breach within 30 days of becoming
aware of the breach. All sublicenses shall survive the termination of this License.

\item Reformation: If any provision of this License is held to be unenforceable, such provision shall be reformed only to the extent necessary to make it
enforceable.

\item COPYRIGHT NOTICE
\end{enumerate}
\begin{list}{}{}
\item Open Game License v 1.0 Copyright 2000, Wizards of the Coast, Inc.
}{\end{list}}

\newenvironment{productidentity}{%
\footnotesize
\subsection*{Designation of Product Identity}
\begin{list}{}{\leftmargin=0cm}
}{\end{list}}

\newenvironment{opengamecontent}{%
\footnotesize
\subsection*{Designation of Open Game Content}
\begin{list}{}{\leftmargin=0cm}
}{\end{list}}

