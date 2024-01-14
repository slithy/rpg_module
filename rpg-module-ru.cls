%% rpg-module-ru.cls
%
% Класс для LaTeX --- Модуль для Настольных Ролевых Игр
%
% Копирайт 2016 Майкл С. Дэвис
%
% ЛИЦЕНЗИЯ НА РАБОТУ
%
% Эта работа состоит из следующих файлов:
%    rpg-module-ru.cls
%    basic-stats-ru.sty
%    basic-stats-ru.def
%    doc/rpg-module-ru.tex
%
% Эта работа может быть распространена и/или изменена в соответствии с условиями
% лицензии публичного проекта LaTeX, либо версии 1.3, либо (по вашему выбору)
% любой последующей версии. Последнюю версию этой лицензии можно найти на:
% http://www.latex-project.org/lppl.txt
% и версия 1.3 или более поздняя является частью всех сборок LaTeX версии 2005/12/01
% или более поздних.
%
% Эта работа имеет статус LPPL `сопровождается автором'.
% 
% Автор и сопроводитель этой работы --- Майкл С. Дэвис
%
%
% ЛИЦЕНЗИЯ НА КОМПИЛЯЦИЮ
%
% Вы можете распространять скомпилированные работы, созданные с использованием работы,
% как указано в пункте 3 лицензии публичного проекта LaTeX.
% Если вы включаете открытый игровой контент в составленную работу,
% вы также должны соблюдать условия этой лицензии.
%
%
% ИСПОЛЬЗОВАНИЕ
%
% См. документацию в файле rpg-module-ru.pdf (исходный файл doc/rpg-module-ru.tex). 
% Также представлены несколько рабочих примеров в директории examples/.
%
% Техническая поддержка предоставляется на форумах Dragonsfoot:
%
% http://www.dragonsfoot.org/forums/viewtopic.php?f=87&t=73823
%
%
% ИЗВЕСТНЫЕ БАГИ
%
% 1. Спец. скорости не отображаются корректно в описании новых монстров,
% представленных несколькими колонками если только все монстры не имеют
% один и тот же тип скорости
% 2. Формат КБ из S&W плохо справляется с КБ оборотней
%
%
% СПИСОК ДЕЛ
%
% 1. Настройка блоков характеристик по продвинутой редакции правил
% 2. Настройка блоков характеристик по базовой редакции Холмса

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rpg-module}[2016/04/25 Role-Playing Game Module document class]



% Define which stat block systems are recognised. ONE of these environments should be redefined in
% the system-specific stat block package.

\RequirePackage{comment}                                                        % Allow some sections to conditionally appear or not
\excludecomment{ifbasicstats}
\excludecomment{ifadvancedstats}
% \excludecomment{next_system}{...



% Process class options

\newcounter{papersizeoption}
\newcounter{fontoption}
\newcounter{statsoption}
\newcounter{acoption}

\newif\ifmodule@letterpaper
\newif\ifmodule@seriffont
\newif\ifmodule@tightsqueeze

\DeclareOption{letterpaper}{\module@letterpapertrue\stepcounter{papersizeoption}}
\DeclareOption{a4paper}{\module@letterpaperfalse\stepcounter{papersizeoption}}

\DeclareOption{tightsqueeze}{\module@tightsqueezetrue}

\DeclareOption{serif}{\module@seriffonttrue\stepcounter{fontoption}}
\DeclareOption{sansserif}{\module@seriffontfalse\stepcounter{fontoption}}

\DeclareOption{basic}{\def\statstyle@module{basic-stats-ru.sty}\stepcounter{statsoption}}
\DeclareOption{advanced}{\def\statstyle@module{advanced-stats.sty}\stepcounter{statsoption}}
% \DeclareOption{next_system}{...

% Note: the class does not define a default AC display option. The default is handled by the
% \ac@module macro which is defined in the style file selected by the previous option.

\DeclareOption{acdesc}{\def\acstyle@module{desc}\stepcounter{acoption}}
\DeclareOption{acasc}{\def\acstyle@module{asc}\stepcounter{acoption}}
\DeclareOption{acb1}{\def\acstyle@module{b1}\stepcounter{acoption}}
\DeclareOption{acsw}{\def\acstyle@module{sw}\stepcounter{acoption}}

\DeclareOption*{
   \ClassError{rpg-module}{Unrecognised option '\CurrentOption'}{Valid options are:\MessageBreak
      a4paper,letterpaper,tightsqueeze\MessageBreak serif,sansserif,\MessageBreak basic,advanced,\MessageBreak acdesc,acac,acb1,acsw}
}

\ExecuteOptions{a4paper}                                                        % default paper size is A4
\ExecuteOptions{sansserif}                                                      % default font option is sans serif
\ExecuteOptions{basic}                                                          % default stat block style is basic

\ProcessOptions\relax

\ifcase\thepapersizeoption\or\or\else
   \ClassError{rpg-module}{a4paper and letterpaper options are mutually exclusive}
   {The input file contains a statement like:\MessageBreak
    \protect\documentclass[letterpaper,a4paper]{rpg-module}\MessageBreak
    You can only select one paper size, either letterpaper or a4paper.\MessageBreak
    The default is a4paper.}
\fi

\ifcase\thefontoption\or\or\else
   \ClassError{rpg-module}{serif and sanserif options are mutually exclusive}
   {The input file contains a statement like:\MessageBreak
    \protect\documentclass[serif,sansserif]{rpg-module}.\MessageBreak
    You can only select one font style, either serif or sans serif.\MessageBreak
    The default is sans serif.}
\fi

\ifcase\thestatsoption\or\or\else
   \ClassError{rpg-module}{you can only select one style}
   {The input file contains a statement like:
    \protect\documentclass[basic,advanced]{rpg-module}.
    You can only select one style for stat blocks.\MessageBreak
    The recognised styles are basic and advanced.\MessageBreak
    The default is basic. Advanced will be defined in a future version of the rpg-module class.}
\fi

\ifcase\theacoption\or\else
   \ClassError{rpg-module}{you can only select one AC style}
   {The input file contains a statement like:\MessageBreak
    \protect\documentclass[acasc,acdesc]{rpg-module}.\MessageBreak
    You can only select one style for armour class.\MessageBreak
    The recognised styles are acasc, acdesc, acb1 and acsw.}
\fi



% Process paper size options

\setlength\voffset{-1in}
\setlength\hoffset{-1in}

\ifmodule@letterpaper
   \PassOptionsToClass{letterpaper}{article}
   \addtolength\voffset{-17.6mm}
   \addtolength\hoffset{2.95mm}
   \newcommand{\ArmourClass}{Класс Брони}                                       % Concession to US spelling of Armour
\else
   \PassOptionsToClass{a4paper}{article}
   \PassOptionsToClass{twoside}{article}
   \newcommand{\ArmourClass}{Класс Брони}
\fi

% в строчках выше меняю ArmourClass на Класс Брони

% Load the standard LaTeX 'article' document class that module is based on

\LoadClass[twocolumn]{article}



% Set page margins

\setlength{\oddsidemargin}{0.8cm}
\setlength{\evensidemargin}{0.8cm}

\setlength{\topmargin}{2.6cm}

\setlength{\textheight}{25.4cm}
\setlength{\textwidth}{19.4cm}

\setlength{\marginparsep}{0cm}
\setlength{\marginparwidth}{0cm}

\setlength{\footskip}{0.7cm}

\setlength{\columnsep}{1.15cm}

\pagenumbering{arabic}

\ifmodule@letterpaper
   \setlength{\headheight}{0cm}
   \setlength{\headsep}{0cm}
\else
   \addtolength{\topmargin}{-\headheight}
   \addtolength{\topmargin}{-\headsep}
   \RequirePackage{fancyhdr}                                                    % Add headers and footers
   \fancypagestyle{plain}{%
      \fancyhf{} % clear all header and footer fields
      \fancyhead[LO,RE]{\slshape \leftmark}
      \fancyhead[RO,LE]{\slshape \rightmark}
      \fancyfoot[C]{\thepage} % except the center
      \renewcommand{\headrulewidth}{0pt}
      \renewcommand{\footrulewidth}{0pt}
   }
   \pagestyle{plain}
\fi



% Float placement options
% See p.199-200 of Lamport's "LaTeX" book for details and p.105 of "TeX Unbound" for suggested values

\renewcommand{\topfraction}{0.9}                                                % max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}                                             % max fraction of floats at bottom

% Parameters for TEXT pages (not float pages)

\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{2}                                                    % for 2-column pages
\renewcommand{\dbltopfraction}{0.9}                                             % fit big float above 2-column text
\renewcommand{\textfraction}{0.07}                                              % allow minimal text

% Parameters for FLOAT pages (not text pages)
%
% Note: \floatpagefraction must be less than \topfraction above

\renewcommand{\floatpagefraction}{0.7}                                          % require fuller float pages
\renewcommand{\dblfloatpagefraction}{0.7}                                       % require fuller float pages



% Process font options

\RequirePackage[T1]{fontenc}                                                    % Use T1 (8-bit) font encoding
\RequirePackage{lmodern}                                                        % Use Latin Modern instead of Computer Modern for symbols etc.
\RequirePackage{xfrac}                                                          % Get a good-looking 1/2 symbol

\newcommand\half{\sfrac{1}{2}}                                                  % Get a good-looking 1/2 symbol

\ifmodule@seriffont
   \IfFileExists{souvenir.sty}{                                                 % If ITC Souvenir font is installed in this LaTeX distribution
      \RequirePackage{souvenir}                                                 % Use ITC Souvenir as serifed font
      \renewcommand{\bfdefault}{d}                                              % Use demi-bold instead of bold
      \renewcommand*\copyright{{\usefont{T1}{lmr}{m}{n}\textcopyright}}         % Get a good-looking copyright (C) symbol
      \newcommand*\registered{{\usefont{T1}{lmr}{m}{n}\textregistered}}         % Registered trademark (R) symbol
      \renewcommand\half{{\usefont{T1}{lmr}{m}{n}\sfrac{1}{2}}}                 % Redefine font for 1/2 symbol
   }{
      \ClassWarning{rpg-module}{%
         ITC Souvenir not detected, substituting Bookman as default serifed font.}
      \RequirePackage{bookman}                                                  % Use Bookman as serifed font
   }
   \renewcommand*\familydefault{\rmdefault}                                     % Default to serifed font
\else
   \RequirePackage{avant}                                                       % Use URW Gothic as default sans-serif font (similar to ITC Avant Garde Gothic)
   \renewcommand*\familydefault{\sfdefault}                                     % Default to sans-serif font
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



% Load the rest of the required packages

\RequirePackage[pass,paperwidth=\paperwidth,paperheight=\paperheight]{geometry} % Page size
\RequirePackage[explicit,newparttoc]{titlesec}                                  % Redefine section headings
\RequirePackage{titletoc}                                                       % Redefine table of contents
\RequirePackage{array}                                                          % Format table headings
\RequirePackage{booktabs}                                                       % Underline table headings
\RequirePackage{caption}                                                        % Allow non-numbered figure and table captions
\RequirePackage{framed}                                                         % Boxed text
\RequirePackage{graphicx}                                                       % Allow images and text across two columns
\RequirePackage{dblfloatfix}                                                    % Allow positioning of figure* at bottom of page
\RequirePackage{xstring}                                                        % Manipulate strings

% Hyperlinks

\RequirePackage[linktocpage]{hyperref}                                          % Allow hyperlinks, only page numbers in TOC are clickable
\RequirePackage[dvipsnames]{xcolor}                                             % Pre-defined colour names
\hypersetup{colorlinks=true,
    urlcolor=MidnightBlue,                                                      % Colour for external links
    linkcolor=MidnightBlue,                                                     % Colour for internal links (including Table of Contents)
    citecolor=MidnightBlue}                                                     % Colour for references

% Key-value pairs, used for stat blocks

\RequirePackage{pgfkeys}
\RequirePackage{pgfmath}

% Define a narrow breaking space

\newcommand*{\thinspacebrk}{\hskip0.16667em\relax}

% Tightsqueeze option for reduced spacing

\ifmodule@tightsqueeze
   \titlespacing*{\part}{0pt}{0pt}{0pt}
   \titlespacing*{\section}{0pt}{0.5ex plus .2ex}{0.5ex plus .2ex}
   \titlespacing*{\subsection}{0pt}{0.5ex plus .2ex}{0.5ex plus .2ex}
   \FrameSep5pt
   \renewcommand{\arraystretch}{1}
\else
   \renewcommand{\arraystretch}{1.2}                                            % Default: increase the table row spacing a little
\fi

% Footnote options

\renewcommand*{\thefootnote}{\fnsymbol{footnote}}                               % Use footnote symbols instead of numbers
\renewcommand\@makefntext[1]{\leftskip=0.5em\hskip-0.5em\makebox[0.5em]{\@makefnmark}#1}             % Footnote indentation

% The freestyle (system-independent) stat block
%
% Other stat-block styles depend on the RPG system option chosen and are defined in the appropriate .sty file

\newenvironment{statblockfreestyle}{\begin{list}{}{\leftmargin=1em\rightmargin=1em}\item}{\end{list}}

% Define monsters

\newcounter{currentstat}                                                        % Counter for setting up key-value pairs

\newcommand{\monster}[4][default]{
   \pgfkeys{/#2/SingleName/.initial = {#3}}
   \ifnum\pdfstrcmp{#1}{default}=\z@
      \IfEndWith{#3}{y}
      {\pgfkeys{/#2/PluralName/.initial = \StrGobbleRight{#3}{1}ies}}           % Plural names ending in -y change to -ies
      {
         \IfEndWith{#3}{s}
         {\pgfkeys{/#2/PluralName/.initial = #3es}}                             % Plural names ending in -s change to -ses
         {\pgfkeys{/#2/PluralName/.initial = #3s}}                              % Default case, plurals where we add -s
      }
   \else
      \pgfkeys{/#2/PluralName/.initial = #1}                                    % Override for irregular plurals
   \fi
   \setcounter{currentstat}{0}
   \def\currentmonster{#2}
   \scan@stats#4|\relax|
}

% Load system-specific stat blocks

\InputIfFileExists{\statstyle@module}{%
   \ClassInfo{rpg-module}{Loading monster stats from \statstyle@module}
}{%
   \ClassWarning{rpg-module}{Monster stats style \statstyle@module\space not found,\MessageBreak
   defaulting to basic-stats-ru.sty}
   \input{basic-stats-ru.sty}
}

% Title Page

\renewcommand\maketitle{\hypersetup{pageanchor=false}% No internal links to title page allowed
\begin{titlepage}
\vspace*{\fill}
\begin{center}
\Huge \textbf{\@title} \par
\@author
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

\renewcommand\@author{\relax}
\renewcommand{\author}[1]{\gdef\@author{\vskip 0.5em\LARGE \textbf{by #1}}}

\newcommand\@subtitle{\relax}
\newcommand\@coverimg{\relax}
\newcommand\@abstract{\relax}
\newcommand\@copyright{\relax}
\newcommand\@contact{\relax}

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



% Running heads (used on A4 paper size only)

\newcommand\titlerunning[1]{%
   \gdef\runningtitle{\MakeUppercase{#1}}
}

\ifmodule@letterpaper\else
   \renewcommand{\partmark}[1]{\markright{\MakeUppercase{#1}}{}}
   \renewcommand{\sectionmark}[1]{}
   \renewcommand{\subsectionmark}[1]{}
   \renewcommand{\leftmark}{\runningtitle}
   \titlerunning{\@title}
\fi


% Headings

\renewcommand\thepart{\arabic{part}}
\renewcommand\thesection{}
\renewcommand\thesubsection{\arabic{subsection}}
\renewcommand\thesubsubsection{\arabic{subsection}\alph{subsubsection}}

\titleformat{\part}[block]
{\LARGE\bfseries\filcenter}
{\LARGE PART \thepart:}{0.5em}{\MakeUppercase{#1}}

\titleformat{\section}[hang]
{\Large\bfseries\filright}
{}{0em}{\MakeUppercase{#1}}

\titleformat{name=\section,numberless}[block]                                   % how to handle \section*
{\Large\bfseries\filcenter}
{}{0em}{#1\phantomsection\addcontentsline{toc}{section}{#1}}

\titleformat{\subsection}[hang]
{\normalfont\bfseries\filright}
{\thesubsection.}{0.5em}{\MakeUppercase{#1}}

\titleformat{\subsubsection}[hang]                                              % \subsubsection is indentical to \subsection except for the numbering
{\normalfont\bfseries\filright}
{\thesubsubsection.}{0.5em}{\MakeUppercase{#1}}

% Default section spacing, for reference
%
%\titlespacing*{\chapter} {0pt}{50pt}{40pt}
%\titlespacing*{\section} {0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}
%\titlespacing*{\subsection} {0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
%\titlespacing*{\subsubsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
%\titlespacing*{\paragraph} {0pt}{3.25ex plus 1ex minus .2ex}{1em}
%\titlespacing*{\subparagraph} {\parindent}{3.25ex plus 1ex minus .2ex}{1em}

% Table of Contents

\renewcommand\tableofcontents{%
   \noindent\Large\textbf{\MakeUppercase\contentsname}\vspace{1em}\@starttoc{toc}
}


\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}
\titlecontents{part}[0em]{\normalsize\bfseries}{PART \thecontentslabel : \MakeUppercase}{}{\quad\thecontentspage}[\vspace{1.5ex plus .2ex}]
\titlecontents*{section}[0em]{\normalsize}{}{}{~\thecontentspage}[\unskip, ][.\vspace{1.5ex plus .2ex}]
\titlecontents*{subsection}[0em]{\normalsize}{}{}{~\thecontentspage}[\unskip, ][.\vspace{1.5ex plus .2ex}]
\titlecontents*{subsubsection}[0em]{\normalsize}{}{}{~\thecontentspage}[\unskip, ][.\vspace{1.5ex plus .2ex}]



% Boxed text

\newenvironment{boxtext}{%
\if@nobreak
   \vspace{-\topsep}
\fi
\begin{framed}\@afterheading}{\end{framed}\aftergroup\@afterindentfalse\aftergroup\@afterheading}



% Single-column text

\newcommand\onecolumninline[1]{%
\newlength{\tmpparindent}
\newlength{\tmpparskip}
\setlength{\tmpparindent}{\parindent}
\setlength{\tmpparskip}{\parskip}
\twocolumn[{
\setlength{\parindent}{\tmpparindent}
\setlength{\parskip}{\tmpparskip}
\fussy
#1
\vspace{2ex}
}]
}

\newenvironment{onecolumnfloat}[1][t]{%
\let\@floatboxreset\relax%
\let\@parboxrestore\relax%
\begin{table*}[#1]\unskip}{\end{table*}}



% Tables

\newcolumntype{b}{>{\bfseries}c}                                                % New column type 'b' for bold, centred headings
\newcounter{numcols@module}                                                     % Counter to keep track of how many columns are in the table

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
   \newcommand\source{\string\multicolumn\lbracetoken 1\rbracetoken\lbracetoken#1\rbracetoken\lbracetoken#2\rbracetoken}
   \newcommand\replace{\rbracetoken&\string\multicolumn\lbracetoken 1\rbracetoken\lbracetoken#1\rbracetoken\lbracetoken}
   \StrSubstitute{\source}{ & }{\replace}[\tmptblhdr]
   \StrExpand{\tmptblhdr}{\tmptblhdrexpand}
   \tokenize{\tmptbltok}{\tmptblhdr}
   \global\let\tableheader@module\tmptbltok
}\\[-2ex] % hack to get around the fact that it's not allowed to have non-expandable text in the same cell as \multicolumn
\tableheader@module\\
\tableul{\thenumcols@module}
}



% Copyright and license macros

\newcommand{\modulecopyright}{%
The \LaTeX~rpg-module class is copyright \copyright 2016 Michael Davis and is distributed under the conditions of the
\href{http://www.latex-project.org/lppl.txt}{LaTeX Project Public License}, either version 1.3 or (at your option)
any later version. Compiled Works generated using the rpg-module class can be distributed as specified in Clause 3 of the license.}

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

\newenvironment{ogl-ru}{%
\footnotesize
\subsection*{ОТКРЫТАЯ ИГРОВАЯ ЛИЦЕНЗИЯ Версия 1.0a}
Нижеследующий текст является собственностью компании Wizards of the Coast, Inc. © 2000 Wizards of the Coast, Inc ("Wizards"). Все права защищены.
\begin{enumerate}
\item Определения: (a) “Авторы Вклада”("Contributors") означает владельцев авторских прав и/или торговой марки, которые вносят вклад в Открытый Игровой Материал; (b) “Вторичный Материал” ("Derivative Material") означает защищенный авторскими правами материал, включая вторичные работы и переводы (в том числе перевод на другие языки программирования), извлечения, изменение, исправление, дополнение, развитие, усовершенствование, улучшение, компиляцию, сокращение, а равно другие формы, в которых имеющаяся работа может быть переработана, преобразована или адаптирована; (c)
“Распространять”("Distribute") означает воспроизводить, лицензировать, предоставлять в пользование, продавать, зачитывать по радио, или телевиденью, публично демонстрировать либо распространять иным способом; (d) “Открытый Игровой Материал”("Open Game Content") означает игровую механику и включает в себя методы, процедуры, процессы и программы в пределах такого материала, не включает в себя Особенности Продукта, является улучшением прототипа и любого дополнительного материала, явно определенных Авторами Вклада в качестве Открытого Игрового Материала, и означает любую работу, предусмотренную данной Лицензией, включая перевод и вторичные работы согласно закону об авторском праве, но специально исключает Особенности Продукта. (e) “Особенности Продукта” ("Product Identity") означает имена товара и товарной линии, логотипы и идентифицирующие знаки, включая торговую одежду; артефакты; характеры; сюжеты, сюжетные линии, интриги, тематические элементы, диалоги, события, язык, иллюстрации, эмблемы, дизайн, изображения, портреты, форматы, позы, концепции, тематику и графику, фотографии и другие визуальные и звуковые представления; имена и описания героев, персонажей, команд, их портреты и специальные возможности, названия и описания заклинаний и чар; места, локации, окружающую обстановку, существ, снаряжение, магические или сверхъестественные способности или воздействия, логотипы, эмблемы или графическое оформление; и любые другие торговые марки или зарегистрированные торговые марки, явно определенные в качестве Особенностей Продукта владельцем Особенностей Продукта, которые специально исключаются из Открытого Игрового Материала; (f) “Торговая марка” ("Trademark") означает логотипы, имена, знак, символ, лозунг, дизайн, которые использованы Автором Вклада для идентификации себя или своих продуктов или связанных продуктов, вносимых им по Открытой Игровой Лицензии. (g) “Использовать” ("Use", "Used" or "Using") означает использовать, Распространять, копировать, редактировать, форматировать, модифицировать, переводить и иным образом создавать Вторичный Материал из Открытого Игрового Материала. (h) “Вы” ("You" or "Your") означает лицензиата в терминах данного соглашения.

\item Лицензия: данная Лицензия применяется к любому Открытому Игровому Материалу, который содержит уведомление о том, что Открытый Игровой Материал можно Использовать только в соответствии с условиями соглашения данной Лицензии. Вы должны приложить такое уведомление к любому Открытому Игровому Материалу, который Вы Используете. Никакие условия соглашения не могут быть добавлены к данной Лицензии или изъяты из нее иначе, как описано в самой Лицензии. Никакие другие условия не могут накладываться на Открытый Игровой Материал, распространяемый в соответствии с данной Лицензией.

\item Предложение и Согласие: Используя Открытый Игровой Материал, Вы тем самым признаете и принимаете условия соглашения данной Лицензии.

\item Разрешение и Компенсация: В обмен на согласие применять данную Лицензию Авторы Вклада предоставляют Вам бессрочную повсеместную бесплатную не-эксклюзивную лицензию на Открытый Игровой Материал в точном соответствии с условиями соглашения данной Лицензии.

\item Заявление о полномочиях на свой Вклад: Если Вы вносите первичный материал в качестве Открытого Игрового Материала, то Вы заявляете, что Ваш Вклад является Вашим оригинальным произведением и/или Вы имеете достаточно прав, чтобы передавать права, предоставленные Вам данной Лицензией.

\item Уведомление об Авторских Правах Лицензии: Вы обязаны изменять в соответствии с новыми данным часть УВЕДОМЛЕНИЯ ОБ АВТОРСКИХ ПРАВАХ данной Лицензии, чтобы включить точный текст УВЕДОМЛЕНИЯ ОБ АВТОРСКИХ ПРАВАХ любого Открытого Игрового Материала, который Вы копируете, изменяете или распространяете, и Вы должны добавить к УВЕДОМЛЕНИЮ ОБ АВТОРСКИХ ПРАВАХ название, дату авторских прав и название держателя авторских прав любого оригинального Открытого Игрового Материала, который Вы Распространяете.

\item Использование Особенностей Продукта: Вы соглашаетесь не Использовать какие-либо Особенности Продукта, в том числе в виде указания на совместимость, иначе чем путем заключения специального Соглашения для получения лицензии от владельца каждого элемента этих Особенностей Продукта. Вы соглашаетесь не указывать на совместимость или приспособляемость работы, содержащей Открытый Игровой Материал, относительно любой Торговой марки или Зарегистрированной Торговой Марки иначе, чем путем заключения специального Соглашения для получения лицензии от владельца такой Торговой Марки или Зарегистрированной Торговой Марки. Использование любых Особенностей продукта в Открытом Игровом Материале не должно нарушать права собственности владельца этих Особенностей Продукта. Владелец любых Особенностей Продукта, используемых в Открытом Игровом Материале, сохраняет все права и привилегии по отношению к этим Особенностям Продукта.

\item Идентификация: Если Вы распространяете Открытый Игровой Материал, Вы должны явно указать, какая именно часть распространяемой Вами работы являются Открытым Игровым Материалом.

\item Обновление Лицензии: компания Wizards или назначенные ею Агенты могут публиковать обновленные версии данной Лицензии. Вы можете использовать любую авторизованную версию данной Лицензии, для того чтобы копировать, изменять и распространять любой Открытый Игровой Материал, изначально распространенный по любой версии этой Лицензии.

\item Копия данной Лицензии: Вы ОБЯЗАНЫ включить копию данной Лицензии в каждую копию Открытого Игрового Материала, который Вы Распространяете. 

\item Использование Имени Публикатора: Вы не можете продавать или рекламировать Открытый Игровой Материал с использованием имени любого Публикатора, пока не получите на то его письменного разрешения.

\item Невозможность Выполнения: Если Вы не имеете возможности выполнить какое-либо из условий соглашения этой Лицензии по отношению к части или всему Открытому Игровому Материалу, в силу законодательных актов, решения суда, или постановлений правительства, то Вы не можете Использовать любой Открытый Игровой Материал в указанных пределах.

\item Прекращение действия: Действие данной Лицензии прекращается автоматически, если Вы не в состоянии выполнять все ее условия соглашения и не сможете исправить нарушение этих условий соглашения в течение 30 дней после того, как узнали о нарушении. Все сублицензии остаются в силе после прекращения действия данной лицензии.

\item Изменения: Если любое положение данной Лицензии становится неосуществимым, такое положение будет изменено лишь в той степени, чтобы сделать его осуществимым.

\item УВЕДОМЛЕНИЯ ОБ АВТОРСКИХ ПРАВАХ
\end{enumerate}
\begin{list}{}{}
\item Открытая Игровая Лицензия (Версия 1.0a) Copyright 2000, Wizards of the Coast, Inc.
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

