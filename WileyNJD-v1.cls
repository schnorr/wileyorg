%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This file is copyright by SPi Technologies Ltd. All rights reserved.
%%
%% Author:       SPi, LaTeX Development Team, Chennai (India)
%% Created On: 
%% Last Modified By:
%% Last Modified On:
%% Description:  Class file to support authoring template in LaTeX typesetting 
%%               for Wiley Journals
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[2009/09/24]
\ProvidesClass{WileyNJD-v1}
              [2016/09/12 v0.1 Standard LaTeX document class for Journal]

\newif\if@cropmarkson\@cropmarksonfalse
\newif\if@croppage\@croppagefalse
\newif\if@draftruleson\@draftrulesonfalse
\newif\if@exactptsize\@exactptsizefalse
\newif\if@purexml\global\@purexmlfalse
\newif\if@xml\global\@xmlfalse
\newif\if@hyperrefon  \@hyperrefonfalse%
\newif\ifbibunnumbered\global\bibunnumberedtrue%
\newif\ifAQ\global\AQfalse%
\newif\ifproof\global\prooffalse%
\newif\ifEqnSpan\global\EqnSpantrue% 


\newif\if@APArefstyle\global\@APArefstylefalse%
\newif\if@AMSrefstyle\global\@AMSrefstylefalse%
\newif\if@AMArefstyle\global\@AMArefstylefalse%
\newif\if@Vancouverrefstyle\global\@Vancouverrefstylefalse%
\newif\if@Chemistryrefstyle\global\@Chemistryrefstylefalse%

\DeclareOption{APA}{\global\@APArefstyletrue}
\DeclareOption{AMS}{\global\@AMSrefstyletrue}
\DeclareOption{ACS}{\global\@Chemistryrefstyletrue}
\DeclareOption{AMA}{\global\@AMArefstyletrue}
\DeclareOption{VANCOUVER}{\global\@Vancouverrefstyletrue}

\DeclareOption{draftrules}{\global\@draftrulesontrue}
\DeclareOption{exactsize}{\global\@exactptsizetrue}%
\DeclareOption{noexactsize}{\global\@exactptsizefalse}%
\DeclareOption{croppage}{\global\@croppagetrue\global\@cropmarksontrue}%
\DeclareOption{number}{\xdef\@biboptions{numbers}}
\DeclareOption{numbers}{\xdef\@biboptions{numbers}}
\DeclareOption{query}{\global\AQtrue\def\qhead{\vbox{\Qheadfnt Composition Comments}\par}}%
\DeclareOption{noquery}{\global\AQfalse\def\qhead{}}%
\DeclareOption{EqnSpan}{\global\EqnSpantrue}%%

\DeclareOption{proof}{%
%%\global\AQtrue%
\global\prooftrue%
\global\@hyperrefontrue%
}%

\DeclareOption{final}{%
\global\AQfalse%
\global\prooffalse%
\global\@hyperrefontrue% links and bookmarks are removed through PDF action list post PDF creation
}%

\def\@JrnlID{}%
\gdef\JrnlID#1{\gdef\@JrnlID{#1}}%

\def\@YES{YES}%
\def\@NO{NO}%

%
%%%%%%%%% From Boolean Package %%%%%%%%%
%

\newcommand {\TRUE}[2]{#1}
\newcommand {\FALSE}[2]{#2}

%% Public commands are also given inner hidden names

\let \bln@true \TRUE
\let \bln@false \FALSE

\newcommand {\AND}[2]{#1{#2}{\bln@false}}
\newcommand {\OR}[2]{#1{\bln@true}{#2}}
\newcommand {\NOT}[1]{#1{\bln@false}{\bln@true}}
\newcommand {\IF}[3]{#1{#2}{#3}}

\let \bln@and \AND
\let \bln@or  \OR
\let \bln@not \NOT
\let \bln@if  \IF


%% To convert if.. macros into Booleans:

\newcommand {\texbool}[1]
    {#1\let \bln@do \bln@true \else \let \bln@do \bln@false\fi \bln@do}
%% Does not work
\let \bln@tex \texbool

\newcommand {\ifxbool}[2]
    {\ifx #1#2\let \bln@do \bln@true \else \let \bln@do \bln@false \fi \bln@do}
\let \bln@ifx \ifxbool

\newcommand {\ifybool}[2]
    {\def \bln@testa{#1}\ifxbool{\bln@testa}{#2}}
\let \bln@ify \ifybool

\newcommand {\ifequalbool}[2]
    {\def \bln@testa{#1}\def \bln@testb{#2}\ifxbool{\bln@testa}{\bln@testb}}
\let \bln@ifequal \ifequalbool

\def \bln@empty {}
\newcommand {\ifemptybool}[1]
    {\ifybool{#1}{\bln@empty}}
\let \bln@ifempty \ifemptybool

%% To force evaluation, e.g. if a blnlean expression is to be used several
%% times. This takes a Boolean expression and returns a Boolean value, i.e.
%% \True or \False.

\newcommand* {\letboolval}[2]
        {#2{\let #1\bln@true}{\let #1\bln@false}}
\newcommand* {\newboolval}[2]
        {\@ifdefinable #1{\letboolval{#1}{#2}}}

%% We provide list versions of And and Or

\def \bln@scan #1,#2\bln@to#3#4{%
    \bln@ifempty{#2}{#3{#4}{#1}}
          {\bln@scan #2\bln@to {#3}{#3{#4}{#1}}}%
}
\def \bln@eval #1#2#3{%
    \bln@ifempty{#1}{#3}%
          {\bln@scan #1,\bln@to {#2}{#3}}%
}

\newcommand*{\ANDL}[1]{\bln@eval {#1}{\bln@and}{\bln@true}}
\newcommand*{\ORL} [1]{\bln@eval {#1}{\bln@or}{\bln@false}}

%% In some contexts, shorter names may be more convenient

\newcommand*{\ShorterBooleanNames}{%
  \let \true  \bln@true
  \let \false \bln@true
  \let \or    \bln@or
  \let \and   \bln@and
  \let \not   \bln@not
  \let \orl   \bln@orl
  \let \andl  \bln@andl
}

%% Comparisson between strings

\newcommand {\stringmatch}[3]{%
   \def \@match ##1#2##2\str@sep ##3\str@sep ##4\str@end
        {#1{##1}{##2}{\ifequalbool{#2}{##3}}}%
   \@match #3\str@sep #2\str@sep \str@sep \str@end
}
\let \str@match \stringmatch

%% The following commands takes in order Prefix Infix Suffix Left

\def \str@infix  #1#2#3{#3}
\def \str@prefix #1#2#3{\AND{#3}{\ifemptybool{#1}}}
\def \str@suffix #1#2#3{\AND{#3}{\ifemptybool{#2}}}

\newcommand {\ifstringinfix} {\str@match {\str@infix}}
\newcommand {\ifstringsuffix}{\str@match {\str@suffix}}
\newcommand {\ifstringprefix}{\str@match {\str@prefix}}

%%%%%%%%%%% From ifjobname Package %%%%%%%%%%%%%

\edef \@jobname {\jobname}

%% Simple equality
\def \job@eattwo #1#2{}
\def \ifjobname #1{%
   \edef \job@tmp {\expandafter \string \csname x#1\endcsname}%
   \edef \job@name {\expandafter \job@eattwo \job@tmp}%
   \ifxbool{\@jobname}{\job@name}%
}

%%

\newtoks \job@temptoken

\def \ifjob@iffix #1#2{%
   \edef \@tmp {\expandafter \string \csname x#2\endcsname}%
   \edef \job@name {\expandafter \job@eattwo \@tmp}%
   \job@temptoken{\def \@match ##1}%
   \@temptokena={##2\relax ##3\relax
           {\def \tmp@prefix {##1}\def \tmp@suffix {##2}\def \tmp@left
           {##3}}}%
   \let \arg@one \job@name%
   \edef \@tmp{\the \job@temptoken\job@name\the \@temptokena}\@tmp
   \edef \@tmp{\noexpand\@match \@jobname \relax \job@name \relax \relax}\@tmp
   #1}

\def \job@infix {\ifxbool{\tmp@left}{\arg@one}}
\def \job@suffix
     {\AND{\ifxbool{\tmp@left}{\arg@one}}{\ifxbool{\empty}{\tmp@suffix}}}
\def \job@prefix
     {\AND{\ifxbool{\tmp@left}{\arg@one}}{\ifxbool{\empty}{\tmp@prefix}}}

\newcommand {\ifjobinfix} {\ifjob@iffix {\job@infix}}
\newcommand {\ifjobsuffix}{\ifjob@iffix {\job@suffix}}
\newcommand {\ifjobprefix}{\ifjob@iffix {\job@prefix}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%\ExecuteOptions{twosidecrop,crop,centre,noinfo,a3paper,exactsize,croppage}%
\ProcessOptions
\LoadClass[twoside,fleqn,onecolumn]{article}%

%\usepackage{etex}%
%\reserveinserts{28}% included etex package and \reserveinserts{...} to avoid no room for \newinserts, \newcounts or \newskips etc.
\RequirePackage{graphicx,multicol}%
\RequirePackage{multirow}%
\RequirePackage{ifpdf}%
\RequirePackage{url}\def\UrlFont{}%\urlstyle{sf}
\RequirePackage[strict]{changepage}%
\RequirePackage{calc}%
\RequirePackage{xcolor}%
\RequirePackage{float}%
\RequirePackage{floatpag}%
\floatpagestyle{headings}%
\rotfloatpagestyle{headings}%modified from plain to headings to get header and footer for sidewaystable%
\RequirePackage{dblfloatfix}%
\RequirePackage[figuresright]{rotating}%
\RequirePackage{longtable}%
%%\RequirePackage{threeparttable}%
%%\RequirePackage{ulem}%
\RequirePackage{enumerate}%
%%
%\if@hyperrefon%
%  \if@xml%
     \RequirePackage{hyperref}%
%  \else%
%     \RequirePackage{hyperref}%
%  \fi%
%  \RequirePackage{breakurl}%
  \hypersetup{bookmarksopen=true,%
              bookmarksdepth=3}%
  \RequirePackage{bookmark}% if bookmark package is commented bookmarks are getting printed at the beginning of the file in the output
%\else%
%  \RequirePackage{hyperref}%
%  \RequirePackage{breakurl}%
%  \hypersetup{bookmarksopen=true,%
%              bookmarksdepth=3}%
%  \RequirePackage{bookmark}% if bookmark package is commented bookmarks are getting printed at the beginning of the file in the output
%\fi%
\RequirePackage [labelformat=empty]{subfig}%
\RequirePackage{twoopt}%
\RequirePackage[bottom]{footmisc}% to place footnotes below floats

\if@xml%
\else%
%%%%%% For pagenumbering automations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{alphalph}%
\usepackage[pagecontinue=true,alphMult=ab,AlphMulti=AB,fnsymbolmult=true,romanMult=true,RomanMulti=true]{pageslts}
\AtBeginDocument{\pagenumbering{arabic}}%% for pagesLTS package
%%%%%% end pagenumbering automations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\fi%

\AtBeginDocument{\usepackage{setspace}\doublespacing}%

\RequirePackage{tabularx}%%  COMPULSARILY HAS TO BE INPUTTED TO USE \tabpara% XMT: Update

%\newcounter{boxcnt}%
%\newcommand\boxsection[1]{\begingroup\vskip2pt%
%\refstepcounter{boxcnt}%
%\vbox{{\textcolor{black!75}{\bfseries BOX \theboxcnt.}}\quad {\bfseries#1}}\par%
%\removelastskip\vskip4pt%
%\endgroup}


\usepackage[framemethod=default]{mdframed}
\mdfsetup{linewidth=1pt,topline=true,bottomline=true,skipabove=\topskip,skipbelow=\topskip}
\newenvironment{boxtext}{\begingroup%
\begin{mdframed}}{\par\end{mdframed}\endgroup}



%% ========================================================= %%
%% If array package is included before dcolumn package,      %%
%% array environment inside eqnarray throw errors            %%
%% array package is included in dcolumn package; do not      %%
%% include array.sty again in Wileyarticle.cls anywhere;     %%
%% ========================================================= %%
\RequirePackage{varwidth}%
\RequirePackage{dcolumn}% 
%
%% Fonts Used
%
\usepackage[T1]{fontenc}

%\RequirePackage[not1,notextcomp,lcgreekalpha]{stix}%
%%
\if@exactptsize%
\def\set@fontsize#1#2#3{%
\@defaultunits\@tempdimb#2bp\relax\@nnil
\edef\f@size{\strip@pt\@tempdimb}%
\@defaultunits\@tempskipa#3bp\relax\@nnil
\edef\f@baselineskip{\the\@tempskipa}%
\edef\f@linespread{#1}%
\let\baselinestretch\f@linespread
\def\size@update{%
\baselineskip\f@baselineskip\relax
\baselineskip\f@linespread\baselineskip
\normalbaselineskip\baselineskip
\setbox\strutbox\hbox{%
\vrule\@height.7\baselineskip
\@depth.3\baselineskip
\@width\z@}%
\let\size@update\relax}%
}%
\fi%
%
\newcommand{\textbaselineskip}{13pt}%
%
\renewcommand\normalsize{%
   %%\@setfontsize\normalsize{10bp}{11.5pt}%
   \@setfontsize\normalsize{10pt}{13pt}% 
   \abovedisplayskip 13\p@ \@plus2\p@ \@minus0\p@
   \abovedisplayshortskip \z@ \@plus3\p@%
   \belowdisplayshortskip 13\p@ \@plus2\p@ \@minus2\p@%
   \belowdisplayskip \abovedisplayskip%
   \let\@listi\@listI
   }%
\normalsize%

\renewcommand\small{%
   %%\@setfontsize\small{9bp}{10.5pt}%
   \@setfontsize\small{9pt}{10.5pt}% 17Dec2016
   \abovedisplayskip 5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 3\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip\abovedisplayskip}

\renewcommand\footnotesize{%
   %%\@setfontsize\footnotesize{8bp}{9.5pt}% \@plus0.1\p@ \@minus0.1\p@}%
   \@setfontsize\footnotesize{8pt}{9.5pt}% \@plus0.1\p@ \@minus0.1\p@}% 17Dec2016
%   \abovedisplayskip 5\p@ \@plus2\p@ \@minus4\p@
%   \abovedisplayshortskip \z@ \@plus\p@
%   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
%   \def\@listi{\leftmargin\leftmargini
%               \topsep 3\p@ \@plus\p@ \@minus\p@
%               \parsep 2\p@ \@plus\p@ \@minus\p@
%               \itemsep \parsep}%
%   \belowdisplayskip \abovedisplayskip
}
%
\renewcommand\scriptsize{\undefined\@setfontsize\scriptsize\@ixpt\@ixpt}%
%
\DeclareMathSizes{\@ixpt}{\@ixpt}{7}{5}%
\DeclareMathSizes{\@xpt}{\@xpt}{7}{5}%
\DeclareMathSizes{\@xipt}{\@xipt}{7}{5}%
\DeclareMathSizes{\@xiipt}{\@xiipt}{8}{6}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Layout Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\setlength{\paperwidth}{210mm}% 
\setlength{\paperheight}{276mm}% 
%%\showthe\paperwidth% 
%%\showthe\paperheight% 

%%\setlength\topskip{0\p@}%
\setlength\headheight{6pt}%

\newbox\RHbox%
\setbox\RHbox=\hbox{\reset@font\fontfamily{\rmdefault}\fontsize{10bp}{0}\selectfont Tyha/}% 17Dec2016
%%\showthe\ht\RHbox%

\newdimen\RHboxhtdim%
\RHboxhtdim=\ht\RHbox%

\newdimen\RHboxdpdim%
\RHboxdpdim=\dp\RHbox%

\setlength\headsep{23.19bp}%
\addtolength{\headsep}{-\RHboxdpdim}%
%%\showthe\headsep%% 26.42038pt

\setlength{\textwidth}{42pc}%
\addtolength{\textwidth}{1.8pt}%
%%\showthe\textwidth% 500pt

\newdimen\hsizevalue%
%\hsizevalue=30pc%
\hsizevalue=42pc%

\addtolength{\hsizevalue}{1.8pt}%

\setlength{\textheight}{54\baselineskip}% 
\addtolength\textheight{-6.2\p@}%
%%\showthe\textheight%

\setlength\topmargin{2pc}% 
\addtolength\topmargin{4\p@}%
%%\addtolength{\topmargin}{-\RHboxhtdim}%
\addtolength{\topmargin}{-1in}%
%%\showthe\topmargin

\setlength\oddsidemargin{50\p@}%
%%\showthe\oddsidemargin
\addtolength{\oddsidemargin}{-1in}%

\setlength\evensidemargin\paperwidth%
\addtolength\evensidemargin{-\textwidth}%
\addtolength\evensidemargin{-\oddsidemargin}% 
%%\showthe\evensidemargin%
\addtolength{\evensidemargin}{-2in}%
%
\setlength\footskip{0\p@}%
\setlength\maxdepth{5pt}%
%
%
%
\newdimen\parindentvalue%
\parindentvalue=1em%
%
\setlength\parindent{\parindentvalue}%
%
\ifpdf%
    \global\@cropmarksonfalse%
\else%
    \if@cropmarkson%
        \RequirePackage{crop}%
        \if@croppage%
            \CROP@size{\paperwidth}{\paperheight}%
        \fi%
    \fi%
\fi%

%
% Footnotes
%
%%\renewcommand\thefootnote{\@fnsymbol\c@footnote}%

%


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pagination Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Line spacing
\setlength\lineskip{0\p@}%
\setlength\normallineskip{0\p@}%
\renewcommand\baselinestretch{}%
\parskip=\z@%

\pagenumbering{arabic}%
\sloppy%
\frenchspacing%
%%\flushbottom

%%% special parameters for TeX
\adjdemerits=100
\linepenalty=100


% Page break penalties
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

% Disallow widows and orphans
\clubpenalty 10000
\widowpenalty 10000

% Disable page breaks before equations, allow pagebreaks after
% equations and discourage widow lines before equations.
\displaywidowpenalty 100
\predisplaypenalty   10000
\postdisplaypenalty  0

% Set these global demerits
\doublehyphendemerits 1000000% corresponds to badness 800
\finalhyphendemerits  1000000% corresponds to badness 1000

% Allow loose lines rather than overfull lines
\vbadness=9999%
\tolerance=9999%


% Allow breaking the page in the middle of a paragraph
\interlinepenalty 0%

% Disallow breaking the page after a hyphenated line
\brokenpenalty 10000%

% Hyphenation; don't split words into less than three characters
\lefthyphenmin=3%
\righthyphenmin=3%

% Float placement parameters

% The total number of floats that can be allowed on a page.
\setcounter{totalnumber}{10}%

% The maximum number of floats at the top and bottom of a page.
\setcounter{topnumber}{3}%
\setcounter{bottomnumber}{3}%

% The maximum part of the top or bottom of a text page that can be
% occupied by floats. This is set so that at least four lines of text
% fit on the page.
\renewcommand\topfraction{.921}%
\renewcommand\bottomfraction{.921}%

% The minimum amount of a text page that must be occupied by text.
% This should accomodate four lines of text.
%%\renewcommand\textfraction{.13}%
\renewcommand\textfraction{.1}%

% The minimum amount of a float page that must be occupied by floats.
%%\renewcommand\floatpagefraction{.887}%
\renewcommand\floatpagefraction{.95}%

% The same parameters repeated for double column output
%%\renewcommand\dbltopfraction{.88}%
%%\renewcommand\dblfloatpagefraction{.88}%
\renewcommand\dbltopfraction{.95}%
\renewcommand\dblfloatpagefraction{.95}%

% Space between floats
\setlength\floatsep{24\p@ \@plus 2.875\p@ \@minus 1.4375\p@}%

% Space between floats and text
\setlength\textfloatsep{24\p@ \@plus 2.875\p@ \@minus 1.4375\p@}%
%
%%\def\resettextfloatsep{\makeatletter\setlength\textfloatsep{13.5\p@ \@plus 2.875\p@ \@minus 1.4375\p@}\makeatother}%
%
% Space above and below an inline figure
\setlength\intextsep{24\p@ \@plus 2.875\p@ \@minus 1.4375\p@}%

% For double column floats
\setlength\dblfloatsep{24\p@ \@plus 2.875\p@ \@minus 1.4375\p@}%
\setlength\dbltextfloatsep{24\p@ \@plus 2.875\p@ \@minus 1.4375\p@}%

\hyphenation{Figure Figures Table Tables Equation Equations Section Sections Appendix Theorem Lemma Proposition Corollary}% 
\hyphenation{Claim Conjecture Property Remark Problem Example Definition Algorithm Assumption Axiom Case Hypotheses Note Proof}% 

%%% miscellaneous macros %%%
\def\zz#1{\vphantom{#1}}%
\def\nobreaktie{\penalty\@M\hbox{\ }} % tie

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Draftrules %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%% To print grid lines on all pages
\newdimen\pageheight\global\pageheight=\textheight%
\newcount\rulecount\rulecount=1%
%
\newdimen\leftcolrulepos
\newdimen\rightcolrulepos
%
\edef\slugtoday{\two@digits{\the\day}/\two@digits{\the\month}/\the\year}%
%
\def\PrintGridLines{%
{\color{black!10}%
    {%
    \loop%
    \ifdim\pageheight>0pt%
        \ifnum\rulecount=1%
            \advance\pageheight by -1.5pt%
        \fi%
        \AtTextUpperLeft{%x
          \put(0,\LenToUnit{-\pageheight}){%
            \line(1,0){\LenToUnit{\leftcolrulepos}}}}%
%%14Mar16%%
        \AtTextUpperLeft{%
        \put(\LenToUnit{\rightcolrulepos},\LenToUnit{-\pageheight}){%
           \line(1,0){\LenToUnit{\leftcolrulepos}}}}%
        \advance\pageheight-11.5pt%baseline
        \advance\rulecount\@ne%
    \repeat%
}}}%
%
\RequirePackage{showframe}
\if@draftruleson%
%
\renewcommand\ShowFramePicture{%
\leftcolrulepos\columnwidth%
\rightcolrulepos\columnwidth%
\advance\rightcolrulepos by \columnsep%
  \begingroup
    \normalcolor\thinlines%
    \put(0,0){
%    \if@watermarkon\AtTextUpperLeft{%
%      \put(\LenToUnit{\textwidth},41){\llap{\fontsize{8}{10}\selectfont {\rm JrnlID\ \@JrnlID\_ArtID \@artid\_Proof\#1 - \slugtoday}}}}\fi%
    \AtTextLowerLeft{%
      \framebox(\LenToUnit{\textwidth},\LenToUnit{\textheight}){}}%
      \linethickness{.1pt}%
      \PrintGridLines%
    \AtTextLowerLeft{%
      \put(0,\LenToUnit{-\footskip}){%
        \line(1,0){\LenToUnit{\textwidth}}}}%
        \AtTextLowerLeft{%
          \put(\LenToUnit{\columnwidth},0){%
            \line(0,1){\LenToUnit{\textheight}}}}%
            %%For marginpar
%%14Mar16%%
        \AtTextLowerLeft{%
          \put(\LenToUnit{\rightcolrulepos},0){%
            \line(0,1){\LenToUnit{\textheight}}}}%
    \AtTextLowerLeft{%
      \@tempdima=\textwidth\advance\@tempdima\marginparsep%
      \if@twoside%
        \ifodd\c@page
          \if@mparswitch
            \@tempdima=-\marginparsep\advance\@tempdima-\marginparwidth%
          \fi
        \else%
          \@mparswitchfalse
          \if@mparswitch
            \@tempdima=-\marginparsep\advance\@tempdima-\marginparwidth%
          \fi
        \fi%
      \fi%
    }}%
  \endgroup
}%
\else
\renewcommand\ShowFramePicture{%
\leftcolrulepos\columnwidth%
\rightcolrulepos\columnwidth%
\advance\rightcolrulepos by \columnsep%
  \begingroup
    \normalcolor\thinlines%
    \put(0,0){
%    \if@watermarkon\AtTextUpperLeft{%
%      \put(\LenToUnit{\textwidth},41){\llap{\fontsize{8}{10}\selectfont {\rm JrnlID\ \@JrnlID\_ArtID \@artid\_Proof\#1 - \slugtoday}}}}\fi%
    }%
  \endgroup
}%
\fi%

%% Miscellaneous macros %%

\newdimen\artopleftskipdim%
\artopleftskipdim=36.25pt%

\def\hb{\hfill\break}%
\def\uns{\ifmmode\,\else$\,$\fi}%
\def\raggedcenter{\leftskip=0pt plus 0.5fil\rightskip=0pt plus 0.5fil\parfillskip=0pt}%
\def\artopraggedright{\leftskip=\artopleftskipdim\rightskip=0pt plus 1fil\parfillskip=0pt\relax}%

%% Metadata Info %%

\def\@artid{xx}% pub-id
\def\@jname{xxx}%
\def\@jvol{\emph{xxx}}%
\def\@eissn{xx}%
\def\@pissn{xx}%
%%\def\@copyyear{xxxx}%
\def\copyyr{xxxx}%
\def\@jnlyear{xxxx}%
\def\@doi{}%
\def\@pubname{ }%
\def\@arteditor{}%

\def\artid#1{\gdef\@artid{#1}}%
\def\@jid{}%
\def\jid#1{\gdef\@jid{#1}}%
\def\jname#1{\gdef\@jname{#1}}%
\def\jvol#1{\gdef\@jvol{#1}}%
\def\eissn#1{\gdef\@eissn{#1}}%
\def\pissn#1{\gdef\@pissn{#1}}%
\def\copyyear#1{\gdef\copyyr{#1}}%
\def\jyear#1{%%\gdef\copyyear{#1}
\gdef\@jnlyear{#1}}%
\def\doi#1{\gdef\@doi{#1}}%
\def\pubname#1{\gdef\@pubname{#1}}%
%%\def\arteditor#1{\gdef\@arteditor{\acadeditorfont Academic Editor:\ #1}}%
%%\def\aceditor#1{\gdef\@arteditor{\acadeditorfont Academic Editor:\ #1}}%

\def\jmonth#1{\gdef\@jmonth{#1}}%


\def\@copyeditor{}%
\def\copyeditor#1{\gdef\@copyeditor{#1}}%

\def\orcid[#1]#2#3{}%
\newcommand{\orgdiv}[1]{#1}%
\newcommand{\orgname}[1]{#1}%
\newcommand{\orgaddress}[1]{#1}%
\newcommand{\street}[1]{#1}%
\newcommand{\postcode}[1]{#1}%
\newcommand{\city}[1]{#1}%
\newcommand{\state}[1]{#1}%
\newcommand{\country}[1]{#1}%

%%\def\PI#1{{#1}}%
%%\def\licenseVal#1{}%

\def\@copyname{}%
\newcommand\copyrightinfo[2][]{\if!#2!\gdef\@copyname{}\else\gdef\@copyname{\copyrightfont#2\ \@licenseVal}\fi}%

%% Macros for firstpage %%

\def\startpage#1{%
  \gdef\temp{#1}%
  \ifx\temp\@empty%
    \def\@firstpage{1}%
  \else%
    \def\@firstpage{#1}%
    \setcounter{page}{#1}%
    \setcounter{spagecounter}{#1}%
  \fi%
}%
\def\@firstpage{}

\def\endpage#1{\gdef\@endpage{#1}}
\def\@endpage{}

%
%% Cross Link for Author & Address
%
\def\jmkLabel#1{\@bsphack\protected@write\@auxout{}{\string\Newlabel{#1}{\@currentlabel}}\@esphack}%
\def\Newlabel#1#2{\expandafter\xdef\csname X@#1\endcsname{#2}}%
\def\jmkRef#1{\@ifundefined{X@#1}{0}{\csname X@#1\endcsname}}%

%
%%%%%%%%%%%%%%%%%% Updation for xml conversion
%
\gdef\@FirstPg{}%
\gdef\@LastPg{}%
%
\def\FirstPg#1{\if!#1!\else\gdef\@FirstPg{#1}\fi}%
\def\LastPg#1{\if!#1!\else\gdef\@LastPg{#1}\fi}%

%\newcount\LastAQCnt%

\newwrite\@xmlpage
\openout\@xmlpage=\jobname.pag
\newcounter{spagecounter}
\newcounter{lpagecounter}
%%\AtBeginDocument{\setcounter{spagecounter}{\c@page}}
\AtEndDocument{\setcounter{lpagecounter}{\c@page}%
\addtocounter{lpagecounter}{-1}%
\immediate\write\@xmlpage{\string\FirstPg{\thespagecounter}\string\LastPg{\thelpagecounter}}%
\immediate\write\@auxout{\string\FirstPg{\thespagecounter}\string\LastPg{\thelpagecounter}}%
\immediate\closeout\@xmlpage%
}%

%% Fonts definitions %%

\def\RHfont{\reset@font\fontfamily{\rmdefault}\fontsize{10bp}{0}\selectfont}%
\def\OPRHfont{\reset@font\fontfamily{\rmdefault}\fontsize{8bp}{9.5}\selectfont}%
\def\DocHeadfont{\reset@font\fontfamily{\rmdefault}\fontsize{14bp}{0}\itshape\selectfont}%
\def\ArtTitlefont{\reset@font\fontsize{18bp}{20}\selectfont\mathversion{bold}\bfseries\raggedright}% 
\def\Authorfont{\reset@font\fontfamily{\rmdefault}\fontsize{12bp}{14}\selectfont\mathversion{bold}\artopraggedright}% 
\def\addressfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{11.25}\selectfont\itshape\artopraggedright}%
\def\corresfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{10.5}\selectfont\artopraggedright}%
\def\historyfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{10.5}\selectfont}%
\def\acadeditorfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{10.5}\selectfont\artopraggedright}%
\def\copyrightfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{10.5}\selectfont\artopraggedright}%
\def\abstractfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{10.5}\selectfont}%
\def\@keyfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{10.5}\selectfont\leftskip0pt}%
%
\def\sectionfont{\reset@font\fontfamily{\rmdefault}\fontsize{11bp}{12}\fontseries{b}\selectfont\mathversion{bold}\raggedright}% 
\def\subsectionfont{\reset@font\fontfamily{\rmdefault}\fontsize{10bp}{11}\fontseries{b}\selectfont\raggedright}% 
\def\subsubsectionfont{\reset@font\fontfamily{\rmdefault}\fontsize{10bp}{11}\fontseries{b}\selectfont\raggedright}% 
\def\paragraphfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{11}\fontseries{b}\selectfont\raggedright}% 
\def\subparagraphfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{11}\fontseries{b}\selectfont\raggedright}% 
%
\def\figurenumfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{10.5}\selectfont}% 
\def\figurecaptionfont{\reset@font\fontfamily{\rmdefault}\fontsize{9bp}{15}\selectfont}% 
\def\subfiglabelfont{\reset@font\fontfamily{\rmdefault}\fontsize{8bp}{13}\selectfont\baselineskip=13pt}%
%
%
\def\listfont{\reset@font\fontfamily{\rmdefault}\normalsize}%
\def\tablistfont{\tablebodyfont}% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% article front matter elements %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% article opening Running headers %%

\def\artoprunningheaders{\vbox{\OPRHfont\raggedright%
\@pubname\par%
\@jname\par%
Volume\ \@jvol, Article ID\ \@artid, \lastpageref*{LastPages}~pages\par%
%%\if@hyperrefon\urlstyle{same}\burlalt{http://dx.doi.org/\@doi}{http://dx.doi.org/\@doi}\else{http://dx.doi.org/\@doi}\fi% this line is not required in the output
}}

\def\nullartoprunningheaders{\vbox{\OPRHfont\raggedright%
\phantom{\@pubname}\par%
\phantom{\@jname}\par%
\phantom{Volume\ \@jvol, Article ID\ \@artid, \lastpageref*{LastPages} pages}\par%
%%\if@hyperrefon\urlstyle{same}\burlalt{http://dx.doi.org/\@doi}{http://dx.doi.org/\@doi}\else{http://dx.doi.org/\@doi}\fi%
}}

%% article category %%

\def\@DocHead{}%
\def\articletype#1{\gdef\@DocHead{\hsize=\textwidth\DocHeadfont#1}}%

%% article title %%

\def\titlemark#1{\gdef\@titlemark{#1}}%
\gdef\@titlemark{}%

%%\def\titlefootnotemark#1{\textsuperscript{\hbox{\reset@font\fontsize{12.5}{0}\selectfont$\@fnsymbol{#1}$}}}%
\def\titlefootnotemark#1{\textsuperscript{$\@fnsymbol{#1}$}}%

\def\title#1{\gdef\@title{\hsize=\textwidth%
\ArtTitlefont#1\addcontentsline{toc}{chapter}{#1}% for bookmarks
}}%
\def\shrttitle#1{\gdef\@shrttitle{#1}}\shrttitle{}%

%% article authors %%

\let\sep\@empty%
\let\authorsep\@empty%
\let\emailsep\@empty%

\newcount\aucount%
\newcount\corrauthcount%

%%\def\au@and{\unskip\advance\punctcount by -1, }%
\def\au@and{\ifnum\punctcount=1\else\ifnum\punctcount=2\ and\advance\punctcount by -1\else\advance\punctcount by -1 \fi \fi}%
\def\artauthors{}

\newif\if@auemail%

\newcommand{\thecorrauthcount}{\the\corrauthcount}%
\newcommand{\theaucount}{\the\aucount}%
\newcommand{\thefnmCnt}{\the\fnmCnt}%

\newcount\authfncnt%
\authfncnt=0%

\newcount\authfnTmpCnt%
\authfnTmpCnt=1%
%
\gdef\StoreAuthFnText#1#2{%
\edef\GetRoman{\romannumeral#1}%
\expandafter\gdef\csname\GetRoman StoreAuthFnTxt\endcsname{#2}%
}%
%
\def\authfndefns{%
\loop\ifnum\authfncnt>0%
   \csname\romannumeral\authfnTmpCnt StoreAuthFnTxt\endcsname\par%
   \StepDownCounter{\authfncnt}%
   \StepUpCounter{\authfnTmpCnt}%
\repeat}%


\def\author{\advance\aucount\@ne%
%%\let\footnotetext\authfootnotetext%
\@ifstar\@@corrauthor\@@author}%

\newcommand{\@@corrauthor}[2][]{\g@addto@macro\artauthors{\undefined%
\renewcommand{\email}[1]{}%
\hsize=\textwidth\raggedright%
\global\advance\aucount\@ne%%
\global\advance\corrauthcount\@ne%%
\def\@currentlabel{#2}
\jmkLabel{corrauth\thecorrauthcount}%
\Authorfont%
\def\baselinestretch{1}%
\authorsep{#2\ifnum\aucount=2\else\ifnum\punctcount=2,\else\ifnum\punctcount=1\relax\else\ifnum\punctcount=0\relax\else,\fi\fi\fi\fi}%
\unskip\ifx#1\empty\else\textsuperscript{\smash{{%
\@for\@@affmark:=#1\do{\edef\affnum{\@ifundefined{X@\@@affmark}{1}{\jmkRef{\@@affmark}}}%
\unskip\sep\affnum\let\sep=,}}}}\fi%
\def\authorsep{\au@and~}%
\global\let\sep\@empty%
}}%

\newcommand\fnm[1]{{\StepUpCounter{\fnmCnt}#1\addtocontents{aq}{\protect{\bfseries Author\ \thefnmCnt}\hfill\protect\break Given Names: #1\hfill\protect\break}}}%
\newcommand\sur[1]{{#1\addtocontents{aq}{Last Name: #1\protect\par}}}%

\newbox\aufootnotemark%

\newcommand{\@@author}[2][]{%\showthe\aucount%
\g@addto@macro\artauthors{%%
\def\footnotemark##1{\global\setbox\aufootnotemark\hbox{\reset@font\fontsize{8.5}{0}\selectfont$\@fnsymbol{##1}$}}%
\renewcommand{\email}[1]{}%
\hsize=\textwidth\raggedright%
\Authorfont%
\def\baselinestretch{1}%
\authorsep{#2\ifnum\aucount=2\ \else\ifnum\punctcount=2,\else\ifnum\punctcount=1\relax\else\ifnum\punctcount=0\relax\else,\fi\fi\fi\fi}%
\unskip\ifx#1\empty\else\textsuperscript{\smash{{%
\@for\@@affmark:=#1\do{\edef\affnum{\@ifundefined{X@\@@affmark}{1}{\jmkRef{\@@affmark}}}%
\unskip\sep\affnum\let\sep=,}}}\unhbox\aufootnotemark}\fi%
\def\authorsep{\au@and~}%
\global\let\sep\@empty}}%

%%\if@purexml\else%
%
\newcounter{affn}%
\renewcommand\theaffn{\arabic{affn}}%
%
\def\jmkaddress{}%
\def\miscjmkaddress{}%
\def\addsep{\par\vskip0pt}%
%
\newcount\addcount% To check the count of address
%
\def\address{\advance\addcount\@ne\@ifstar\@@corraddress\@@address}%
%
\newcommand{\@@corraddress}[2][]{\gdef\@corresinfo{#2}}%
%
\newcommand{\@@address}[2][]{\def\temp{#1}%
\g@addto@macro\jmkaddress{\hsize=\textwidth%
\def\baselinestretch{1}%
\stepcounter{affn}%
\xdef\@currentlabel{\theaffn}%
\jmkLabel{#1}%
\addressfont\ifx#1\empty\else\@hangfrom{\textsuperscript{\smash{\theaffn}}}\fi%
#2\vphantom{Thy}\par%
}}%
%%\fi%

%% email details %%

\newcount\emailcount%
\newcount\punctcount%

%\def\jmkemail{}%
%\def\emailand{\ and\ }%
%\def\@emailsep{\unskip\advance\emailcount by -1\emailand}%

%\newcommand{\email}[1]{%%\global\advance\emailcount\@ne%
%\let\emailcount\corrauthcount%
%\g@addto@macro\jmkemail{%
%\def\emailau{\jmkRef{corrauth\thecorrauthcount};}%
%\emailsep{\emailau\ #1}\def\emailsep{\@emailsep}}}%

\newcommand{\email}[1]{Email: #1}%

%
%% Correspondence details
%

%\def\corresinfotext{Correspondence should be addressed to }%
%\newcommand{\corresinfo}{{\hsize=\textwidth\corresfont\corresinfotext\jmkemail\par}}%

\gdef\@corresinfo{}%
\def\corres#1{\gdef\@corresinfo{#1}}%

\newcommand{\corresinfo}{{\hsize=\textwidth\corresfont\textbf{Correspondence:}\ \@corresinfo\par}}%

\gdef\@presentaddress{}%
\def\presentaddress#1{\gdef\@presentaddress{\hsize=\textwidth\corresfont\textbf{Present Address:}\ #1}}%

%
%% Article History
%
\newcommand{\received}[2][Received]{\gdef\@received{\historyfont #1\ #2;}}\gdef\@received{}%

\newcommand{\revised}[2][Revised]{\gdef\@revised{\historyfont #1\ #2;}}\gdef\@revised{}%

\newcommand{\accepted}[2][Accepted]{\gdef\@accepted{\historyfont #1\ #2}}\gdef\@accepted{}%

\newcommand{\published}[2][Published]{\gdef\@published{\historyfont #1\ #2}}\gdef\@published{}%

\def\history{\vbox{\historyfont\leftskip=\artopleftskipdim%
\ifx\@received\empty\else\@received\fi%
\ifx\@revised\empty\else\space\@revised\fi%
\ifx\@accepted\empty\else\space\@accepted\fi%
%%\ifx\@published\empty\else\par\@published\fi%
}}%

%% Abstract %%

\renewcommand\abstract[2][]{%
  \gdef\@abstract{%
    \setlength{\parindent}{\z@}%
   % \vspace*{8.5\p@}%
    \rightskip0pt\raggedright\hbox{\bfseries{#1}}\par\vskip3pt% 
    {\hsize\textwidth#2\par\vspace*{0\p@}}%
    \addcontentsline{toc}{section}{\abstractname}%
\nobreak}}%\abstract{}%


%% Keywords %%

\def\keywords#1{\def\@keywords{{\@keyfont\textbf{Keywords:}\ #1\par}}}\def\@keywords{}%

\def\@fnsymbol#1{\ifcase#1\or \dagger\or \ddagger\or
   \S\or \P\or \#\or \|\or **\or \dagger\dagger
   \or \ddagger\ddagger\or \S\S\or \P\P\or \#\#\or \|\|\else\@ctrerr\fi\relax}

\renewcommand{\maketitle}{\par%
  \@afterindentfalse%
  \begingroup
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \def\@makefnmark{\hbox to\z@{$\m@th^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
         \twocolumn[\@maketitle]%
      \else
         \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{empty}\@thanks%
    \insert\footins{\authfndefns}\par%
  \endgroup
%  \let\footnotetext\oldfootnotetext%
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}
  \@afterheading%
}

\newskip\adjtitleskip%

\renewcommand{\@maketitle}{{\unskip%
\hsize=\textwidth\parindent=0pt%
\thispagestyle{empty}%
%%\let\footnote\thanks%
%\removelastskip\vskip-21.13pt%
%\ifproof\artoprunningheaders\else\nullartoprunningheaders\fi\par%
\removelastskip\vskip10pt%
\ifx\@DocHead\empty%
  \zz{\@DocHead\par}%
\else%
  {\@DocHead\par}%
\fi%
\removelastskip\vskip4pt%
\ifx\@title\empty\else{\@title\par}\fi%
\removelastskip\vskip18pt%
\ifnum\aucount>0%
   \global\punctcount\aucount%
   {\artauthors\par}%
   \removelastskip\vskip8.25pt%
   {\jmkaddress\par}%
\fi%
   \removelastskip\vskip9pt%
   \ifx\@corresinfo\empty\else{\corresinfo\par}\fi%
   \removelastskip\vskip8pt%
   \ifx\@presentaddress\empty\else\@presentaddress\fi%
   \removelastskip\vskip8pt%
   {\history\par}%
   \removelastskip\vskip12pt%
   \ifx\@abstract\empty\else{\@abstract\par}\fi%
   \removelastskip\vskip9pt%
   \ifx\@keywords\empty\else{\@keywords\par}\fi%
   \vspace*{20pt plus4pt minus2pt}%
   \removelastskip\vskip\adjtitleskip%
}}%

%\renewcommand\thefootnote{\@arabic\c@footnote}%

%
%%


%
%% Regular pagestyle %%
%

\def\@authormark{}%
\def\authormark#1{\markboth{{{#1}}}{{#1}}}%%\gdef\@authormark{\gdef\etal{{et al.}}#1}\gdef\@authormarkforcite{\def\etal{{et al.}}#1}}%

\def\ps@headings{%
\let\@oddfoot\@empty\let\@evenfoot\@empty%
\def\@oddhead{\hbox to \textwidth{\rightmark\hss\llap{\thepage}}}%
\def\@evenhead{\hbox to \textwidth{\rlap{\thepage}\hss\leftmark}}%
\let\@mkboth\markboth%
}%
\pagestyle{headings}%
%

%% Macros for Section headings %%

\setcounter{secnumdepth}{3}% 
%

\newif\if@FTSection%
\global\@FTSectionfalse%

\newif\if@unnumsection%
\@unnumsectionfalse%


%% Macros for Bibliography %%

%\newif\ifbackmatter\newcommand{\backmatter}{\par\global\backmattertrue}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Bibliography %%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%\usepackage[\@refoptions]{amsrefs}% 

\if@APArefstyle\relax%
%\xdef\@refoptions{nobysame,author-year}%
\RequirePackage[nobysame,author-year]{amsrefs}

\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{,} { }                            {journal}
    +{}  { \itshape}                     {volume}
    +{}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{partial}{%
    +{}  {}                             {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {journal}
    +{}  { \itshape}                     {volume}
    +{}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
}

\BibSpec{contribution}{%
    +{} {}                             {type}
    +{} { by \PrintNameList}           {author}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\newcommand{\PrintEditorsD}[1]{\def\authenddot{}%
\BibSpec{nameLE}{%
        +{}{}{initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{}{ }{jr}%
}%
\BibSpec{nameBE}{%
        +{}{}{initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
    %    +{}{ }{jr}
}%
\BibSpec{nameinverted}{%
        +{}{} {initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{,}{ } {jr}%
}%
\def\eddot{.}%
\PrintNames{}{ (Ed\Plural{s}\eddot)}{#1}%
\def\set@name@a##1{\unde%
    \begingroup
        \get@current@properties
        \select@auxlanguage
        \def\@tempa{yes}%
        \ifx\@tempa\prop'inverted
            \setbib@nameBE
        \else
            ##1%%%%%%%%%%
        \fi
    \endgroup
}
}

\BibSpec{incollection}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{,} { \PrintEditorsB}              {editor}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
%    +{;} { pp.~\eprintpages}       {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { }                     {title}
    +{.} { \textit}                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { \bf\PrintDateB}                 {date}
%    +{;} { }                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{conference}{%
    +{}  {}                        {title}
    +{}  {\PrintConferenceDetails} {transition}
}


%
\newcommand{\publishertext}[1]{#1)}%
%
\newcommand{\bkchapeprintpages}[1]{%
    \IfEmptyBibField{chapter}{ p. }{, p. }#1%
}%

\BibSpec{innerbook}{%
    +{} { }                            {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { }                            {part}
    +{.}  { In \PrintEditorsD}              {editor}
    +{,} { \textit}                   {title}
    +{} { \bookchapeprintpages}         {pages}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {organization}
%    +{;} { \bookchapeprintpages}         {pages}
    +{} { }                            {address}
    +{,} { \bf\PrintDateB}                 {date}
    +{:} { }                            {publisher}
    +{.} { }                            {note}
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { }                     {title}
    +{.} { \textit}                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \it Technical Report }           {number}
    +{,} { }                            {series}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \bf\PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{:} { \textit}                     {subtitle}
    +{.} { \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}
\BibSpec{newsletter}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { }                     {title}
    +{.} { \textit}                     {conference}
    +{} { \bf}            {date}
    +{,} { }                            {pages}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\renewcommand{\resetbiblist}[1]{%
    \settowidth\labelwidth{\def\thebib{#1}\BibLabel}%
    \leftmargin\labelwidth
    \ifdim\labelwidth=\z@
        \leftmargin=1em
        \itemindent=-\leftmargin
    \else
        \advance\leftmargin\labelsep
    \fi
}

\renewenvironment{bibchapter}[1][\bibname]{%
    \begingroup
        \protected@edef\@{%
                \endgroup
            \protect\chapter*{#1}%
            \protect\bib@div@mark{#1}%
        }%
        \@
}{\par}
\renewenvironment{bibsection}[1][\refname]{%
    \begingroup
        \protected@edef\@{%
                \endgroup
            \protect\section*{#1}%
            \protect\bib@div@mark{#1}%
        }%
        \@
}{\par}

\def\citeleft{}
\def\citeright{}
\def\citemid{,\penalty9999 \space}
\def\citepunct{;}
\def\citeAltPunct{;\ }

\renewcommand{\SingularPlural}[2]{#1}
\renewcommand{\Plural}{\SingularPlural{}}
\BibSpec{nameLE}{
    +{}{}{surname}
    +{,}{\IfEmptyBibField{given}{}{ }}{given}
    +{}{ }{jr}
}
\BibSpec{nameBE}{
    +{}{}{surname}
    +{}{ }{given}
}
\BibSpec{nameinverted}{
    +{}{ }  {surname}%%%%%%%%%
    +{,}{ } {given}
    +{,}{ } {jr}
}
\renewcommand{\PrintNames}{%
    \@ifstar{\PrintNames@a\set@othername}{\PrintNames@a\set@firstname}%
}
\renewcommand{\PrintNames@a}[4]{%
    \PrintSeries{\name}
        {#1}
        {,}{ \& \set@othername}%%%%%%%%%
        {,}{ \set@othername}
        {,}{ \& \set@othername}
        {#2}{#4}{#3}%
}
\def\set@firstname#1{%
    \set@name{#1}\setbib@nameLE
}
\def\set@othername#1{%
    \set@name{#1}\setbib@nameLE
}
\def\set@name#1{%
    \name@split#1,,,\@nil
    \set@name@a
}
\def\set@name@a#1{%
    \begingroup
        \get@current@properties
        \select@auxlanguage
        \def\@tempa{yes}%
        \ifx\@tempa\prop'inverted
            \setbib@nameBE
        \else
            #1%\authenddot%%%%%%%%%%
        \fi
    \endgroup
}


\renewcommand{\PrintEditorsA}[1]{%\unde%
    \ifx\previous@primary\current@primary
        \sameauthors{(ed\Plural{s}.)}%
    \else
        \def\current@bibfield{\bib'editor}%
        \PrintNames{}{ (ed\Plural{s}.)}{#1}%
    \fi
    \erase@field\bib'editor
}

\renewcommand{\PrintEditorsB}{%
    \PrintNames{}{ (Ed\Plural{s}.)}%
}

\renewcommand{\PrintContributions}[1]{%
    \PrintSeries
        {\fld@elt}
        {\print@contribution}
        {}{ and \print@contribution}
        {,}{ \print@contribution}
        {,}{ and \print@contribution}{}{#1}{}%
}



\renewcommand{\PrintReviews}[1]{%
    \PrintSeries{\fld@elt}{}{,}{ }{,}{ }{,}{ }{}{#1}{}%
}
\renewcommand{\PrintPartials}[1]{%
    \PrintSeries
        {\fld@elt}
        {\print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}{}{#1}{}%
}
\renewcommand{\PrintISBNs}[1]{%
    \PrintSeries{\fld@elt}{}{,}{ }{,}{ }{,}{ }{ISBN }{#1}{}%
}
\renewcommand{\voltext}{\IfEmptyBibField{series}{vol.~}{vol.~}}
\renewcommand{\issuetext}{\hskip-2.7pt}
\renewcommand{\DashPages}[1]{%
    p\pp@scan@a#1@\ndash p@\ndash{\pp@scan#1@-p@-{}\@nil}\@nil.~#1%
}

\def\pp@scan#1-#2@-#3#4\@nil{#3}

\def\pp@scan@a#1\ndash#2@\ndash#3#4\@nil{#3}
\renewcommand{\eprintpages}[1]{%
    #1.\IfEmptyBibField{eprint}{}{\IfEmptyBibField{journal}{ pp.}{}}%
}
\newcommand{\bookchapeprintpages}[1]{%
    (pp. #1).%
}
\def\PrintThesisType#1{%
    \thesis@type#1?\@nil{#1}%
}



\renewcommand{\PrintDate}[1]{(\print@date)}
\renewcommand{\PrintDateB}[1]{\print@date}
\newcommand{\issuefont}{\rm}

\renewcommand{\PrintYear}[1]{\bib@year}
\renewcommand{\PrintDatePosted}[1]{\unskip,  posted on \print@date}
\renewcommand{\PrintEdition}[1]{%
    (\afterassignment\print@edition
    \count@ 0#1\relax\@nil).
}
\def\print@edition#1#2\@nil{%
    \ifx\relax#1\relax
        \ifnum\count@>\z@
            \CardinalNumeric\count@
        \else
            ??th%
        \fi
        \ \editiontext
    \else
        \ifnum \count@>\z@ \number\count@ \fi
        #1#2\relax
    \fi
}
\renewcommand{\editiontext}{ed.}

\IfOption{initials}{% TRUE:
    \BibSpec{nameLE}{
        +{}{}{initials}
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}
        +{}{ }{jr}
    }

    \BibSpec{nameBE}{
        +{}{}{surname}
        +{}{ }{initials}
    %    +{}{ }{jr}
    }

    \BibSpec{nameinverted}{
        +{} {}  {surname}
        +{,}{ } {initials}
        +{,}{ } {jr}
    }
}{% initials? FALSE:
} % end conditional code for initials option



\def\@ocitelist#1{%
    \PrintSeries{\InnerCite}%
        {\ocite}%
        {}{ \& \ocite}%
        {,}{ \ocite}%
        {,}{ \& \ocite}%
        {}%
        {#1}%
        {}%
}

\def\PrintCNY#1#2{%
    \oPrintCiteNames{#1}%
    \@ifnotempty{#2}{\@addpunct{,} #2}%
}
\def\PrintCiteNames#1{%
    \leavevmode
    \def\@tempa{#1}%
    \ifx\@tempa\prev@names
    \else
        \gdef\prev@names{#1}%
        \@xp\ifx\@car#1.\@nil\CitePrintUndefined
            #1\relax
        \else
            \print@citenames{#1}%
        \fi
    \fi
}

\def\oPrintCiteNames#1{%
    \leavevmode
    \def\@tempa{#1}%
    \ifx\@tempa\prev@names
    \else
        \gdef\prev@names{#1}%
        \@xp\ifx\@car#1.\@nil\CitePrintUndefined
            #1\relax
        \else
            \oCiteNames{#1}%
        \fi
    \fi
}


\renewcommand{\CiteNames}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {}{\@gobble}%
        {}{ \etaltext\@\@gobble}%
        {}%
        {#1}%
        {}%
}

\newcommand{\oCiteNames}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ \& }%
        {}{\@gobble}%
        {}{ \etaltext\@\@gobble}%
        {}%
        {#1}%
        {}%
}


\let\print@citenames\CiteNames
\renewcommand{\CiteNamesFull}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {,}{ }%
        {,}{ and }%
        {}%
        {#1}%
        {}%
}
\renewcommand{\PrintDate}[1]{(\bib@label@year)}
\def\print@date{%
    \IfEmptyBibField{date}{%
        \IfEmptyBibField{year}{\BibField{status}}{\bib@year}%
    }{%
        \bib@year
    }%
}
\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{.} { \textit}                            {journal}
    +{,}  { \itshape}                     {volume}
	+{} {\parenthesize}                  {number} %updated by prasad
    +{,} { \eprintpages}                {pages}
    +{.} { }                            {status}
    +{.} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{.} { \voltext}                    {volume}
    +{.}  { }                            {address}
    +{:} { }                            {publisher}
    +{:} { }                            {organization}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{incollection}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{.} { }	                   {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{,} {In \PrintEditorsA}              {editor}
    +{}  {\PrintBook}                   {book}
    +{} { \bookchapeprintpages}         {pages}
    +{,} { }                            {booktitle}
    +{}  { }                            {address}
    +{:} { }                            {publisher}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{proceedings}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{.} { \textrm}                     {title}
    +{.} { }                            {part}
    +{:} { \textrm}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { In \textit}			{conference}
    +{.} { }                            {publisher}
    +{,} { }                            {address}
%%    +{,} { }                            {date}
    +{.} { }				{year}
    +{,} { }                            {organization}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { pp. }                            {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
     +{} { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{,} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}


\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { }                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\newcommand{\reportnumber}[1]{%
    (\textit{#1})%
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{} { \PrintDate}                  {date}
    +{.} { }                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{} { \reportnumber	}           {number}
    +{,} { }                            {series}
    +{.} { }                            {address}
    +{:} { }                            {organization}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{misc}{%
    +{}  {\PrintPrimary}                {transition}
    +{} { \PrintDate}                  {date}
    +{.} { }                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \reportnumber	}           {number}
    +{,} { }                            {series}
    +{,} { }                            {address}
    +{:} { }                            {organization}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{.} { \it }                             {title}
    +{,} { }                             {subtitle}
    +{} { \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\global\let\biblistfont\reflistfont%
\renewenvironment{bibsection}[1][\refname]{%
  \addcontentsline{toc}{section}{\refname}% for bookmarks
  \begingroup
    \protected@edef\@{%
      \endgroup%
      \par\addvspace{18.06pt}\nobreak%
      \vbox{\noindent\bfseries\MakeUppercase{#1}\nobreak}\nobreak\par%
      \nointerlineskip\nobreak\vskip6pt\nobreak%
      \protect\bib@div@mark{#1}%
    }%
    \@\nobreak%
}{\par}
%
%\newcommand{\biblistfont}{\normalfont\reflistfont\baselineskip=10\p@% plus0.1pt minus0.1pt%
%}
\renewcommand\@biblist[1][]{%
  \stepcounter{bib@env}%
  \biblistfont%
  \labelsep .5em\relax%
  \list{\BibLabel}{%
  \itemsep3pt%
    \restore@labelwidth%
    \@maxlabelwidth\z@%
    \@nmbrlisttrue%
    \def\@listctr{bib}%
    \let\makelabel\bib@mklab%
    #1\relax%
    \listparindent3pc%
  }%
}%
%
\renewcommand{\resetbiblist}[1]{%
  \settowidth\labelwidth{\def\thebib{#1}\BibLabel}%
  \leftmargin\labelwidth%
  \ifdim\labelwidth=\z@%
    \leftmargin=1.5em%
    \itemindent=-\leftmargin%
  \else%
    \advance\leftmargin\labelsep%
  \fi%
}%
\renewcommand{\citeyear}[2][]{{%
\let\citeleft\relax%
\let\citeright\relax%
\ycite{#2}%
}}%
\else%
\if@AMSrefstyle\relax%
\RequirePackage[numeric,short-journals,nobysame]{amsrefs}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{,} { }                            {journal}
    +{,}  { \textbf}                     {volume}
    +{,}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{partial}{%
    +{}  {}                             {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {journal}
    +{}  { \textbf}                     {volume}
    +{}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
}

\BibSpec{contribution}{%
    +{} {}                             {type}
    +{} { by \PrintNameList}           {author}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { }                            {publisher}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { pp.~}                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{conference}{%
    +{}  {}                        {title}
    +{}  {\PrintConferenceDetails} {transition}
}



\BibSpec{innerbook}{%
    +{.} { }                            {title}
    +{.} { }                            {part}
    +{:} { }                            {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{.} { }                            {note}
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { Technical Report }           {number}
    +{,} { }                            {series}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}


\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \textit}                     {title}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{webpage}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \emph}                       {title}
    +{:} { \emph}                       {subtitle}
    +{}  { \PrintDate}                  {date}
    +{,} { \url}                        {url}
    +{.} { Accessed \PrintDateField}    {accessdate}
    +{.} { }                            {note}
    +{.} {}                             {transition}
}

\renewcommand{\SingularPlural}[2]{#1}
\renewcommand{\Plural}{\SingularPlural{}}
\BibSpec{nameLE}{
    +{}{}{given}
    +{}{\IfEmptyBibField{given}{}{ }}{surname}
    +{}{ }{jr}
}
\BibSpec{nameBE}{
    +{}{}{surname}
    +{}{ }{given}
}
\BibSpec{nameinverted}{
    +{} {}  {surname}
    +{,}{ } {given}
    +{,}{ } {jr}
}
\renewcommand{\PrintNames}{%
    \@ifstar{\PrintNames@a\set@othername}{\PrintNames@a\set@firstname}%
}

\renewcommand{\PrintNames@a}[4]{%
    \PrintSeries{\name}
        {#1}
        {}{ and \set@othername}%two authors
        {,}{ \set@othername}%one author
        {,}{ and \set@othername}%more than two authors
        {#2}{#4}{#3}%
}
 
\renewcommand{\PrintNameList}{\PrintNames{}{}}
\renewcommand{\PrintEditorsC}[1]{%
    \PrintNames{Edited by }{}{#1}%
}
\renewcommand{\PrintEditorsA}[1]{%
    \ifx\previous@primary\current@primary
        \sameauthors{(ed\Plural{s}.)}%
    \else
        \def\current@bibfield{\bib'editor}%
        \PrintNames{}{ (ed\Plural{s}.)}{#1}%
    \fi
    \erase@field\bib'editor
}

\newcommand{\PrintEditorsD}[1]{\def\authenddot{}%
\BibSpec{nameLE}{%
        +{}{}{initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{}{ }{jr}%
}%
\BibSpec{nameBE}{%
        +{}{}{initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
    %    +{}{ }{jr}
}%
\BibSpec{nameinverted}{%
        +{}{} {initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{}{ } {jr}%
}%
\def\eddot{.}%
\PrintNames{}{, Ed\Plural{s}\eddot,}{#1}%
\def\set@name@a##1{\unde%
    \begingroup
        \get@current@properties
        \select@auxlanguage
        \def\@tempa{yes}%
        \ifx\@tempa\prop'inverted
            \setbib@nameBE
        \else
            ##1%%%%%%%%%%
        \fi
    \endgroup
}
}

\renewcommand{\PrintEditorsB}{%
    \PrintNames*{(}{\SwapBreak{,}~Ed\Plural{s}.)}%
}
\renewcommand{\PrintContributions}[1]{%
    \PrintSeries
        {\fld@elt}
        {\print@contribution}
        {}{ and \print@contribution}
        {,}{ \print@contribution}
        {,}{ and \print@contribution}{}{#1}{}%
}
\renewcommand{\print@contribution}[1]{%
    \in@={#1}%
    \ifin@
        \ifnum\series@index=\@ne with \fi
        \RestrictedSetKeys{}{bib}{%
            \bib@print@inner\setbib@contribution{\the\rsk@toks}%
        }{#1}%
    \else
        #1%
    \fi
}
\def\resolve@inner#1#2{%
    \in@={#2}%
    \ifin@
        \RestrictedSetKeys{}{bib}{#1{\the\rsk@toks}}{#2}%
    \else
        \@ifundefined{bi@#2}{%
            \XRefWarning{#2}%
        }{%
            #1{\csname bi@#2\endcsname}%
        }%
    \fi
}
\def\PrintConference{%
    \resolve@inner{\bib@print@inner\setbib@conference}
}
\def\PrintConferenceDetails#1{%
    \ifx\@empty\bib'address
        \ifx\@empty\bib'date
        \else
            \PrintConferenceDetails@
        \fi
    \else
        \PrintConferenceDetails@
    \fi
}
\def\PrintConferenceDetails@{%
    \ifnum\lastkern=\@ne\else\space\fi(\kern 1sp
    \ifx\@empty\bib'address
    \else
        \bib'address
    \fi
    \ifx\@empty\bib'date
    \else
        \SwapBreak{,}\space
        \print@date
    \fi
    )%\spacefactor\sfcode`\,%
}


\renewcommand{\PrintTranslatorsB}[1]{
    \PrintNames*{(}{\SwapBreak{,}~tran\Plural{s}.)}%
}

\renewcommand{\parenthesize}[1]{%
    \leavevmode\push@bracket)\upn{(}#1\pop@bracket
}
\renewcommand{\bibquotes}[1]{%
    \textquotedblleft#1%
    \gdef\deferredquotes{%
        \global\let\deferredquotes\@empty
        \textquotedblright
    }%
}

\renewcommand{\PrintPartials}[1]{%
    \PrintSeries
        {\fld@elt}
        {\print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}{}{#1}{}%
}
\renewcommand{\PrintISBNs}[1]{%
    \PrintSeries{\fld@elt}{}{,}{ }{,}{ }{,}{ }{ISBN }{#1}{}%
}
\renewcommand{\voltext}{\IfEmptyBibField{series}{Vol.~}{vol.~}}
\renewcommand{\issuetext}{no.~}
\renewcommand{\DashPages}[1]{%
    p\pp@scan@a#1@\ndash p@\ndash{\pp@scan#1@-p@-{}\@nil}\@nil.~#1%
}

\def\pp@scan#1-#2@-#3#4\@nil{#3}

\def\pp@scan@a#1\ndash#2@\ndash#3#4\@nil{#3}
\renewcommand{\eprintpages}[1]{%
    #1\IfEmptyBibField{eprint}{}{\IfEmptyBibField{journal}{ pp.}{}}%
}
\def\PrintThesisType#1{%
    \thesis@type#1?\@nil{#1}%
}

\def\thesis@type#1#2\@nil#3{%
    \ifx p#1%
        Ph.D. Thesis%
    \else
        \ifx m#1%
            Master's Thesis%
        \else
            #3%
        \fi
    \fi
}
\renewcommand{\PrintDOI}[1]{%
    doi:#1%
}
\renewcommand{\PrintDatePV}[1]{%
    \IfEmptyBibField{doi}{%
        \let\@tempa\PrintDate
    }{%
        \IfEmptyBibField{volume}{%
            \let\@tempa\PrintDatePosted
        }{%
            \let\@tempa\PrintDate
        }%
    }%
    \@tempa{#1}%
}

\renewcommand{\editiontext}{ed.}

\IfOption{initials}{% TRUE:
    \BibSpec{nameLE}{
        +{}{}{initials}
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}
        +{}{ }{jr}
    }

    \BibSpec{nameBE}{
        +{}{}{surname}
        +{}{ }{initials}
    %    +{}{ }{jr}
    }

    \BibSpec{nameinverted}{
        +{} {}  {surname}
        +{,}{ } {initials}
        +{,}{ } {jr}
    }
}{% initials? FALSE:
} % end conditional code for initials option


\newcommand{\CiteNames}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {}{\@gobble}%
        {}{ \etaltext\@\@gobble}%
        {}%
        {#1}%
        {}%
}
\let\print@citenames\CiteNames
\newcommand{\CiteNamesFull}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {,}{ }%
        {,}{ and }%
        {}%
        {#1}%
        {}%
}

\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \PrintDate}                  {date}
    +{:} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{.} { }                            {journal}
    +{,}  { \textbf}                     {volume}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \PrintDate}                  {date}
    +{:} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{.} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{.} { }                            {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { \PrintDate}                  {date}
    +{:} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { }                            {publisher}
    +{,} { }                            {address}
    +{,} { }                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \PrintDate}                  {date}
    +{:} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{.} { }           {number}
    +{,} { }                            {series}
    +{.} { }                            {organization}
    +{.} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{proceedings}{%
    +{}  {\PrintPrimary}                {transition}
       +{,} { \textit }                     {title}
    +{.} { }            {conference}
 %   +{;} { }                            {place}
    +{.} { }                            {part}
    +{;} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {booktitle}
    +{,} { }                            {publisher}
    +{.} { }                            {organization}
    +{,} { }                            {address}
 +{,} { \PrintDateB}                  {date}
    +{,} { pp. }                            {pages}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{webpage}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { \PrintDate}                  {date}
    +{.} { \emph}                       {title}
    +{:} { \emph}                       {subtitle}
    +{,} { \url}                        {url}
    +{.} { Accessed \PrintDateField}    {accessdate}
    +{.} { }                            {note}
    +{.} {}                             {transition}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%\xdef\@refoptions{numeric,short-journals,nobysame}
\BibSpec{proceedings}{%
    +{}  {\PrintPrimary}                {transition}
       +{,} { \textit }                     {title}
    +{.} { }            {conference}
 %   +{;} { }                            {place}
    +{.} { }                            {part}
    +{;} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {booktitle}
    +{,} { }                            {publisher}
    +{.} { }                            {organization}
    +{,} { }                            {address}
 +{,} { \PrintDateB}                  {date}
    +{,} { pp. }                            {pages}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

%\global\let\biblistfont\reflistfont%
\renewenvironment{bibsection}[1][\refname]{%
  \addcontentsline{toc}{section}{\refname}% for bookmarks
  \begingroup
    \protected@edef\@{%
      \endgroup%
      \par\addvspace{18.06pt}\nobreak%
      \vbox{\noindent\bfseries\MakeUppercase{#1}\nobreak}\nobreak\par%
      \nointerlineskip\nobreak\vskip6pt\nobreak%
      \protect\bib@div@mark{#1}%
    }%
    \@\nobreak%
}{\par}
%
%\newcommand{\biblistfont}{\normalfont\reflistfont\baselineskip=10\p@% plus0.1pt minus0.1pt%
%}
\renewcommand\@biblist[1][]{%
  \stepcounter{bib@env}%
  \biblistfont%
  \labelsep .5em\relax%
  \list{\BibLabel}{%
  \itemsep3pt%
    \restore@labelwidth%
    \@maxlabelwidth\z@%
    \@nmbrlisttrue%
    \def\@listctr{bib}%
    \let\makelabel\bib@mklab%
    #1\relax%
    \listparindent3pc%
  }%
}%
%
\renewcommand{\resetbiblist}[1]{%
  \settowidth\labelwidth{\def\thebib{#1}\BibLabel}%
  \leftmargin\labelwidth%
  \ifdim\labelwidth=\z@%
    \leftmargin=1.5em%
    \itemindent=-\leftmargin%
  \else%
    \advance\leftmargin\labelsep%
  \fi%
}%
\newcommand{\citeyear}[2][]{{%
\let\citeleft\relax%
\let\citeright\relax%
\ycite{#2}%
}}%

\else%
\if@AMArefstyle\relax%
\RequirePackage[numeric,short-journals,nobysame]{amsrefs}
%\xdef\@refoptions{numeric,short-journals,nobysame}
%\global\let\biblistfont\reflistfont%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\PrintEditorsD}[1]{\def\authenddot{}%
\BibSpec{nameLE}{%
        +{}{}{initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{}{ }{jr}%
}%
\BibSpec{nameBE}{%
        +{}{}{initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
    %    +{}{ }{jr}
}%
\BibSpec{nameinverted}{%
        +{}{} {initials}%
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{,}{ } {jr}%
}%
\def\eddot{.}%
\PrintNames{}{ (ed\Plural{s}\eddot)}{#1}%
\def\set@name@a##1{\unde%
    \begingroup
        \get@current@properties
        \select@auxlanguage
        \def\@tempa{yes}%
        \ifx\@tempa\prop'inverted
            \setbib@nameBE
        \else
            ##1%%%%%%%%%%
        \fi
    \endgroup
}
}

\def\citeleft{(}%
\def\citeright{)}%
\def\@citeleft{\ifx\citesel\citesel@object\else\citeleft\fi}%
\def\citepunct{, }

\DeclareRobustCommand{\ocite}[1]{%
    \star@{\cite@a\citesel@object{#1}}{}%
}
\DeclareRobustCommand{\ocites}[1]{%
    \begingroup
        \let\@citelist\@ocitelist
        \cites{#1}%
    \endgroup
}
\def\@ocitelist#1{%
    \PrintSeries{\InnerCite}%
        {\ocite}%
        {}{ \& \ocite}%
        {,}{ \ocite}%
        {,}{ \& \ocite}%
        {}%
        {#1}%
        {}%
}

\def\PrintCiteNames#1{%
    \leavevmode
    \def\@tempa{#1}%
    \ifx\@tempa\prev@names
    \else
        \gdef\prev@names{#1}%
        \@xp\ifx\@car#1.\@nil\CitePrintUndefined
            #1\relax
        \else
            \print@citenames{#1}%
        \fi
    \fi
}
\newcommand{\CiteNames}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ \& }%
        {}{\@gobble}%
        {}{ \etaltext\@\@gobble}%
        {}%
        {#1}%
        {}%
}
\let\print@citenames\CiteNames
\newcommand{\CiteNamesFull}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {,}{ }%
        {,}{ and }%
        {}%
        {#1}%
        {}%
}
\renewcommand{\PrintDate}[1]{(\bib@label@year)}
\def\print@date{%
    \IfEmptyBibField{date}{%
        \IfEmptyBibField{year}{\BibField{status}}{\bib@year}%
    }{%
        \bib@year
    }%
}

\renewcommand{\SingularPlural}[2]{#1}
\renewcommand{\Plural}{\SingularPlural{}}
\BibSpec{nameLE}{
    +{}{}{surname}
    +{,}{\IfEmptyBibField{given}{}{ }}{given}
    +{}{ }{jr}
}
\BibSpec{nameBE}{
    +{}{}{surname}
    +{}{ }{given}
}
\BibSpec{nameinverted}{
    +{} {}  {surname}
    +{,}{ } {given}
    +{,}{ } {jr}
}
\renewcommand{\PrintNames}{%
    \@ifstar{\PrintNames@a\set@othername}{\PrintNames@a\set@firstname}%
}
\renewcommand{\PrintNames@a}[4]{%
    \PrintSeries{\name}
        {#1}
        {,}{ \set@othername}
        {,}{ \set@othername}
        {,}{ \set@othername}
        {#2}{#4}{#3}%
}



\renewcommand{\PrintDate}[1]{(\print@date)}
\renewcommand{\PrintDateB}[1]{\print@date}
\newcommand{\issuefont}{\rm}
\renewcommand{\editiontext}{ed.}


\IfOption{initials}{% TRUE:
    \BibSpec{nameLE}{
        +{}{}{initials}
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}
        +{}{ }{jr}
    }

    \BibSpec{nameBE}{
        +{}{}{surname}
        +{}{ }{initials}
    %    +{}{ }{jr}
    }

    \BibSpec{nameinverted}{
        +{} {}  {surname}
        +{,}{ } {initials}
        +{,}{ } {jr}
    }
}{% initials? FALSE:
} 

\DeclareRobustCommand{\ycites}[1]{%
    \begingroup
        \def\citepunct{, }%
        \let\citesel\citesel@year
        \cites{#1}%
    \endgroup
}
\DeclareRobustCommand{\ocite}[1]{%
    \star@{\cite@a\citesel@object{#1}}{}%
}
\DeclareRobustCommand{\ocites}[1]{%
    \begingroup
        \let\@citelist\@ocitelist
        \cites{#1}%
    \endgroup
}
\def\@ocitelist#1{%
    \PrintSeries{\InnerCite}%
        {\ocite}%
        {}{ \& \ocite}%
        {,}{ \ocite}%
        {,}{ \& \ocite}%
        {}%
        {#1}%
        {}%
}

\renewcommand{\CiteNames}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ \& }%
        {}{\@gobble}%
        {}{ \etaltext\@\@gobble}%
        {}%
        {#1}%
        {}%
}
\let\print@citenames\CiteNames
\renewcommand{\CiteNamesFull}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {,}{ }%
        {,}{ and }%
        {}%
        {#1}%
        {}%
}
\renewcommand{\PrintDate}[1]{(\bib@label@year)}
\def\print@date{%
    \IfEmptyBibField{date}{%
        \IfEmptyBibField{year}{\BibField{status}}{\bib@year}%
    }{%
        \bib@year
    }%
}

\renewcommand{\PrintReviews}[1]{%
    \PrintSeries{\fld@elt}{}{,}{ }{,}{ }{,}{ }{}{#1}{}%
}
\renewcommand{\PrintPartials}[1]{%
    \PrintSeries
        {\fld@elt}
        {\print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}{}{#1}{}%
}
\renewcommand{\PrintISBNs}[1]{%
    \PrintSeries{\fld@elt}{}{,}{ }{,}{ }{,}{ }{ISBN }{#1}{}%
}
\renewcommand{\voltext}{\IfEmptyBibField{series}{Vol.~}{vol.~}}
\renewcommand{\issuetext}[1]{(#1)}
\renewcommand{\DashPages}[1]{%
    p\pp@scan@a#1@\ndash p@\ndash{\pp@scan#1@-p@-{}\@nil}\@nil.~#1%
}


\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{.} { \textit}                            {journal}
    +{.}  { \PrintDateB}                {date}
    +{;}  {}                     {volume}
    +{} {\issuetext}                  {number}
    +{:} {\eprintpages}                {pages}
    +{,} { \PrintDOI}                   {doi}   
 +{,} { }                            {status}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{partial}{%
    +{}  {}                             {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {journal}
    +{}  { \textbf}                     {volume}
    +{}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
}

\BibSpec{contribution}{%
    +{} {}                             {type}
    +{} { by \PrintNameList}           {author}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{.} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{.} { }                            {address}
    +{:} { }                            {publisher}
    +{,} { }                            {organization}
    +{;} { \PrintDateB}                 {date}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{;} { \PrintDateB}                 {date}
    +{:} {}                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{conference}{%
    +{}  {}                        {title}
    +{}  {\PrintConferenceDetails} {transition}
}

\BibSpec{incollection}{%
    +{}  {\PrintAuthors}                {author}
   % +{} { \PrintDate}                  {date}
    +{.} { }	                   {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{,} {In \PrintEditorsA}              {editor}
    +{.}  { \PrintBook}                   {book}
+{} { \PrintDateB}                  {date}
    +{} { \bookchapeprintpages}         {pages}
    +{,} { }                            {booktitle}
    +{}  { }                            {address}
    +{:} { }                            {publisher}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{proceedings}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { }                     {title}
    +{.} { In: }            {conference}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{.} { }                            {publisher}
    +{} { }                            {organization}
    +{;} { \PrintDateB}                  {date}
    +{;} { }                            {address}
    +{:} {}                            {pages}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\newcommand{\PrintEditorsF}{%
    \PrintNames{}{,~ed\Plural{s}.}%
}

\BibSpec{innerbook}{%
    +{} { }                            {subtitle}
    +{,} { }                            {part}
    +{.}  { In: \PrintEditorsF}        {editor}
    +{.} { \textit}                   {title}
    +{.} { \PrintEdition}               {edition}
    +{} { \bookchapeprintpages}         {pages}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {organization}
%    +{;} { \bookchapeprintpages}         {pages}
    +{.} { }                            {address}
%    +{;} { \bf\PrintDateB}                 {date}
    +{:} { }                            {publisher}
    +{.} { }                            {note}
}


\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{.} { }           {number}
    +{,} { }                            {series}
    +{,} { }                            {address}
    +{:} { }                            {organization}
    +{;} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{:} { \textit}                     {subtitle}
    +{.} { \it \PrintThesisType}            {type}
    +{.} { }                            {address}
    +{:} { }                            {organization}
    +{;} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}




\newcommand{\bookchapeprintpages}[1]{%
    (pp. #1).%
}


\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { pp.~}                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{.} { }           {number}
    +{,} { }                            {series}
    +{,} { }                            {address}
    +{:} { }                            {organization}
    +{;} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{,} {\bibquote }                             {title}
    +{,} { }                             {subtitle}
    +{,} { \PrintThesisType}            {type}
    +{,} { }                            {address}
    +{:} { }                            {organization}
       +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\BibLabel}{%
    \hfill
    \Hy@raisedlink{\hyper@anchorstart{cite.\CurrentBib}\hyper@anchorend}%
    \thebib.\ %
}

\BibSpec{misc}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { \textit}                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \reportnumber    }           {number}
    +{,} { }                            {series}
    +{,} { }                            {address}
    +{:} { }                            {organization}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{} {}                             {transition}
    +{;} { \PrintDateB}                  {date}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\def\set@name@a#1{%
    \begingroup
        \get@current@properties
        \select@auxlanguage
        \def\@tempa{yes}%
        \ifx\@tempa\prop'inverted
            #1%
        \else
            \setbib@nameBE
        \fi
    \endgroup
    }


\renewcommand\@biblist[1][]{%
    \stepcounter{bib@env}
    \biblistfont
    \labelsep 2pt\relax
    \list{\BibLabel}{%
%    \itemsep5pt
        \restore@labelwidth
        \@maxlabelwidth\z@
        \@nmbrlisttrue
        \def\@listctr{bib}%
        \let\makelabel\bib@mklab
        #1\relax
    }%
    \sloppy
    \interlinepenalty\@m
    \clubpenalty\@M
    \widowpenalty\clubpenalty
    \frenchspacing
    \ResetCapSFCodes
}
\else%
\if@Vancouverrefstyle\relax%
\RequirePackage[numeric,,short-journals,nobysame]{amsrefs}
%\xdef\@refoptions{numeric,short-journals,nobysame}
%\global\let\biblistfont\reflistfont%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{,} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{} { }                            {journal}
    +{ }  { \PrintDateB}                {date}
    +{;}  { \textbf}                     {volume}
    +{:} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{partial}{%
    +{}  {}                             {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {journal}
    +{}  { \textbf}                     {volume}
    +{}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
}

\BibSpec{contribution}{%
    +{} {}                             {type}
    +{} { by \PrintNameList}           {author}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{;} { \PrintDateB}                 {date}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { \PrintDateB}                 {date}
    +{,} { pp.~}                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{conference}{%
    +{}  {}                        {title}
    +{}  {\PrintConferenceDetails} {transition}
}



\BibSpec{innerbook}{%
    +{.} { }                            {part}
    +{:} { }                            {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{.}  {. In: \PrintEditorsF}              {editor}
    +{.} { \textit}                            {title}
    +{.} { }                            {address}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{:} {}                            {publisher}
    +{,} { }                            {organization}
    +{;} {\PrintDateB}                 {date}
    +{;} { }                            {note}
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{.} { }                            {address}
    +{:} { }                            {organization}
    +{;} { \PrintDateB}                 {date}
    +{.} { }           {number}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{:} { \textit}                     {subtitle}
    +{.} { \it \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}
 
\BibSpec{name}{%
    +{}  {\PrintAuthors}    {name}
}

\BibSpec{publisher}{%
    +{:} { } {publisher}
    +{,} { } {address}
}
 
 
\def\citeleft{\kern4pt}
\def\citeright{}
\def\citemid{,\penalty9999 \space}
%\def\citepunct{;\penalty9999 \hskip.13em plus.1em minus.05em\relax}
\def\citepunct{, }%
\def\citeAltPunct{;\ }%
\providecommand{\citeform}{\@firstofone}
\DeclareRobustCommand{\citelist}{\@citelist}
\def\@citelist#1{%
    \leavevmode
    \begingroup
        \@citestyle
        \citeleft\nopunct   % suppress first \citepunct
        \cite@begingroup
            \in@*{#1}%
            \ifin@
                \let\citepunct\citeAltPunct
            \fi
            \let\cite@endgroup\@empty
            \cites@init
            \def\citeleft{\@addpunct{\citepunct}}%
            \let\citeright\ignorespaces
            \def\cite{}%
                        \@textsuperscript{\nopunct\fontsize{7.5bp}{8bp}\selectfont\hskip-3pt\process@citelist{#1}}%%\process@citelist{#1}%
        \endgroup
        \citeright
    \endgroup
}


\def\@extract@initial#1#2\@nil{%
    \ifx\ini@hyphen#1%
        \add@toks@{\ini@hyphen}%
    \else
        \in@{.\@nil}{#1#2\@nil}% Look for a period at the end of the name
        \ifin@
            \add@toks@{#1#2~}%
        \else
            \count@chars\@tempcnta{#1#2}%
            \ifnum\@tempcnta > \@ne
                \add@toks@{#1.~}%
            \else
                \add@toks@{#1~}%
            \fi
        \fi
    \fi
}


\renewcommand{\SingularPlural}[2]{#1}
\renewcommand{\Plural}{\SingularPlural{.}}
\BibSpec{nameLE}{
    +{}{}{surname}
    +{,}{\IfEmptyBibField{given}{}{ }}{given}
    +{}{ }{jr}
}
\BibSpec{nameBE}{
    +{}{}{surname}
    +{}{ }{given}
}
\BibSpec{nameinverted}{
    +{} {}  {surname}
    +{,}{ } {given}
    +{,}{ } {jr}
}


\newcommand{\PrintEditorsF}{%
    \PrintNames{}{, editors.}%
}

\renewcommand{\PrintPartials}[1]{%
    \PrintSeries
        {\fld@elt}
        {\print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}
        {;}{ \print@partial}{}{#1}{}%
}
\renewcommand{\PrintISBNs}[1]{%
    \PrintSeries{\fld@elt}{}{,}{ }{,}{ }{,}{ }{ISBN }{#1}{}%
}
\renewcommand{\voltext}{\IfEmptyBibField{series}{Vol.~}{vol.~}}
\renewcommand{\issuetext}{\hskip-2.7pt}
\renewcommand{\DashPages}[1]{%
    p\pp@scan@a#1@\ndash p@\ndash{\pp@scan#1@-p@-{}\@nil}\@nil.~#1%
}



\renewcommand{\PrintDOI}[1]{%
    doi:#1%
    \IfEmptyBibField{volume}{, (to appear in print)}{}%
}
\renewcommand{\PrintDatePV}[1]{%
    \IfEmptyBibField{doi}{%
        \let\@tempa\PrintDate
    }{%
        \IfEmptyBibField{volume}{%
            \let\@tempa\PrintDatePosted
        }{%
            \let\@tempa\PrintDate
        }%
    }%
    \@tempa{#1}%
}
\renewcommand{\PrintDate}[1]{(\print@date)}
\renewcommand{\PrintDateB}[1]{\print@date}
\newcommand{\issuefont}{\rm}
 
\renewcommand{\editiontext}{edn.}


\IfOption{citation-order}{%
    \IfOption{alphabetic}{%
        \amsrefs@warning@nl{%
            The citation-order and alphabetic options are
            incompatible%
        }%
    }{
        \def\bibtex@style{amsru}%
    }
}{}
\IfOption{initials}{% TRUE:
    \BibSpec{nameLE}{
        +{}{}{initials}
        +{}{\IfEmptyBibField{initials}{}{ }}{surname}
        +{}{ }{jr}
    }

    \BibSpec{nameBE}{
        +{}{}{surname}
        +{}{ }{initials}
    %    +{}{ }{jr}
    }

    \BibSpec{nameinverted}{
        +{} {}  {surname}
        +{,}{ } {initials}
        +{,}{ } {jr}
    }
}{% initials? FALSE:
} % end conditional code for initials option

%\def\citeleft{(}%
%\def\citeright{)}%
\def\@citeleft{\ifx\citesel\citesel@object\else\citeleft\fi}%
\def\citepunct{, }


\def\@ocitelist#1{%
    \PrintSeries{\InnerCite}%
        {\ocite}%
        {}{ \& \ocite}%
        {,}{ \ocite}%
        {,}{ \& \ocite}%
        {}%
        {#1}%
        {}%
}


\newcommand{\CiteNames}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {}{\@gobble}%
        {}{ \etaltext\@\@gobble}%
        {}%
        {#1}%
        {}%
}
\let\print@citenames\CiteNames
\newcommand{\CiteNamesFull}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {,}{ }%
        {,}{ and }%
        {}%
        {#1}%
        {}%
}

\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{,} { \bibquote}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{,} { \textit}                            {journal}
    +{}  { \bf}                     {volume}
    +{} { \issuetext}                  {number} %updated by prasad
    +{,} { \eprintpages}                {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{} { \PrintDate}                  {date}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { \textit}                     {publisher}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { pp.~}                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { Technical Report }           {number}
    +{,} { }                            {series}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{,} {\bibquote }                             {title}
    +{,} { }                             {subtitle}
    +{,} { \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\def\set@name@a#1{%
    \begingroup
        \get@current@properties
        \select@auxlanguage
        \def\@tempa{yes}%
        \ifx\@tempa\prop'inverted
            #1%
        \else
            \setbib@nameBE
        \fi
    \endgroup
    }

\renewcommand{\PrintDate}[1]{\print@date}
\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { \textrm}                     {title}
    +{.} { }                            {part}
    +{:} { \textrm}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{.} { \PrintPartials}              {partial}
    +{.} { }                     {journal}
    +{.}  { \PrintDatePV}                {date}
    +{;} {\textbf}                    {volume}
    +{}  {\parenthesize}                            {number}
    +{:}  { \eprintpages}                 {pages}
    +{,} { }                            {status}
    +{.} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}


\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{;} { \PrintDateB}                 {date}
    +{.} { p. }                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{.} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{.} { }                            {address}
    +{:} { }                            {organization}
    +{:} { }                            {publisher}
    +{;} { \PrintDate}                  {date}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{proceedings}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { }                     {title}
    +{.} { \textit }            {conference}
 %   +{;} { }                            {place}
    +{.} { }                            {part}
    +{;} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
%    +{,} { }                            {publisher}
    +{;} { }                            {organization}
    +{;} { }                            {address}
    +{;} { \PrintDate}                  {date}
    +{.} { p. }                            {pages}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{misc}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { }                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \reportnumber    }           {number}
    +{,} { }                            {series}
    +{,} { }                            {address}
    +{:} { }                            {organization}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{} {}                             {transition}
    +{;} { \PrintDateB}                  {date}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\renewcommand{\BibLabel}{%
    \hfill
    \Hy@raisedlink{\hyper@anchorstart{cite.\CurrentBib}\hyper@anchorend}%
    \thebib.\ %
}

\newcommand{\citeyear}[2][]{{%
\let\citeleft\relax%
\let\citeright\relax%
\ycite{#2}%
}}%
\else%
\if@Chemistryrefstyle\relax%
\RequirePackage[numeric,short-journals,nobysame,initials]{amsrefs}
%\xdef\@refoptions{numeric,short-journals,nobysame,initials}

\renewcommand{\PrintNames@a}[4]{%
    \PrintSeries{\name}
        {#1}
        {,}{ \set@othername}
        {,}{ \set@othername}
        {,}{ \set@othername}
        {#2}{#4}{#3}%
}
\newcommand{\PrintEditorsD}[1]{\def\authenddot{}%
\BibSpec{nameLE}{%
        +{}{}{initials}%
        +{.}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{}{ }{jr}%
}%
\BibSpec{nameBE}{%
        +{}{}{initials}%
        +{.}{\IfEmptyBibField{initials}{}{ }}{surname}%
    %    +{}{ }{jr}
}%
\BibSpec{nameinverted}{%
        +{}{} {initials}%
        +{.}{\IfEmptyBibField{initials}{}{ }}{surname}%
        +{,}{ } {jr}%
}%
\def\eddot{.}%
\PrintNames{(Ed\Plural{s}: }{#1)}{}%
\def\set@name@a##1{\unde%
    \begingroup
        \get@current@properties
        \select@auxlanguage
        \def\@tempa{yes}%
        \ifx\@tempa\prop'inverted
            \setbib@nameBE
        \else
            ##1%%%%%%%%%%
        \fi
    \endgroup
}
}

\BibSpec{name}{%
    +{}  {\PrintAuthors}    {name}
}

\BibSpec{publisher}{%
    +{:} { } {publisher}
    +{,} { } {address}
}

\def\citeleft{}
\def\citeright{}
\def\citemid{,\penalty9999 \space}
\def\citepunct{,\penalty9999 \hskip.13em plus.1em minus.05em\relax}
\def\citeAltPunct{;\ }
\providecommand{\citeform}{\@firstofone}
\DeclareRobustCommand{\citelist}{\@citelist}
\def\@citelist#1{%
    \leavevmode
    \begingroup
        \@citestyle
        \citeleft\nopunct   % suppress first \citepunct
        \cite@begingroup
            \in@*{#1}%
            \ifin@
                \let\citepunct\citeAltPunct
            \fi
            \let\cite@endgroup\@empty
            \cites@init
            \def\citeleft{\@addpunct{\citepunct}}%
            \let\citeright\ignorespaces
            \def\cite{}%
            \@textsuperscript{\nopunct\fontsize{6.67bp}{6.67bp}\selectfont\ignorespaces[\nopunct\process@citelist{#1}]}%
        \endgroup
        \citeright
    \endgroup
}

\renewcommand{\etalchar}[1]{$^{#1}$}


\newcommand{\bibquote}[1]{%
    \textquoteleft#1%
    \gdef\deferredquotes{%
        \global\let\deferredquotes\@empty
        \textquoteright
    }%
}

\def\SwapBreak#1{%
    \relax\ifvmode\leavevmode\fi
    \@tempcnta\@MM
    \toks@{#1}%
    \unskip
    \ifnum \lastkern>\@ne \unkern \fi
    \ifnum\lastpenalty=\z@
    \else
        \@tempcnta\lastpenalty
        \unpenalty
    \fi
    \edef\@tempa{%
        \@nx\deferredquoteslogical
        \ifnum\lastkern=\@ne
        \else
            \ifnum\spacefactor=\sfcode\@xp\@xp\@xp`\@xp\@car\string#1)\@nil
            \else
                \ifnum\spacefactor=\@nopunctsfcode
                \else
                    \the\toks@
                \fi
            \fi
        \fi
        \@nx\deferredquotes
        \ifnum\@tempcnta=\@MM \else \penalty\number\@tempcnta\space \fi
        \ifnum\lastkern=\@ne \ignorespaces \fi
    }%
    \@tempa
}

\renewcommand{\SingularPlural}[2]{#1}
\renewcommand{\Plural}{\SingularPlural{}}
%\BibSpec{nameLE}{
%    +{}{}{surname}
%    +{,}{\IfEmptyBibField{given}{}{ }}{given}
%    +{}{ }{jr}
%}
%\BibSpec{nameBE}{
%    +{}{}{surname}
%    +{}{ }{given}
%}
%\BibSpec{nameinverted}{
%    +{} {}  {surname}
%    +{,}{ } {given}
%    +{,}{ } {jr}
%}

\renewcommand{\PrintEditorsB}{%
    \PrintNames{}{~(ed\Plural{s}).}%
}


\renewcommand{\parenthesize}[1]{%
    \leavevmode\push@bracket)\upn{(}#1\pop@bracket
}


\renewcommand{\voltext}{\IfEmptyBibField{series}{Vol.~}{vol.~}}
\renewcommand{\issuetext}[1]{(\textit{#1})}
\renewcommand{\DashPages}[1]{%
    p\pp@scan@a#1@\ndash p@\ndash{\pp@scan#1@-p@-{}\@nil}\@nil.~#1%
}

\newcommand{\bookchapeprintpages}[1]{%
    p. #1.%
}


\renewcommand{\PrintDate}[1]{(\print@date)}
\renewcommand{\PrintDateB}[1]{\bfseries\print@date}
\newcommand{\issuefont}{\rm}


\renewcommand{\editiontext}{ed.}

\IfOption{initials}{% TRUE:
    \BibSpec{nameLE}{
        +{}{}{initials}
        +{.}{\IfEmptyBibField{initials}{}{ }}{surname}
        +{}{ }{jr}
    }

    \BibSpec{nameBE}{
        +{}{}{surname}
        +{}{ }{initials}
    %    +{}{ }{jr}
    }

    \BibSpec{nameinverted}{
        +{} {}  {surname}
        +{,}{ } {initials}
        +{,}{ } {jr}
    }
}{% initials? FALSE:
} % end conditional code for initials option

%\def\citeleft{(}%
%\def\citeright{)}%
\def\@citeleft{\ifx\citesel\citesel@object\else\citeleft\fi}%
\def\citepunct{, }
%\def\BibLabel{%
%    \Hy@raisedlink{\hyper@anchorstart{cite.\CurrentBib}\relax\hyper@anchorend}%
%}

\def\@ocitelist#1{%
    \PrintSeries{\InnerCite}%
        {\ocite}%
        {}{ \& \ocite}%
        {,}{ \ocite}%
        {,}{ \& \ocite}%
        {}%
        {#1}%
        {}%
}

\newcommand{\CiteNames}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ \& }%
        {}{\@gobble}%
        {}{ \etaltext\@\@gobble}%
        {}%
        {#1}%
        {}%
}
\let\print@citenames\CiteNames
\newcommand{\CiteNamesFull}[1]{%
    \PrintSeries{\name}%
        {}%
        {}{ and }%
        {,}{ }%
        {,}{ and }%
        {}%
        {#1}%
        {}%
}
\renewcommand{\PrintDate}[1]{(\bib@label@year)}
\def\print@date{%
    \IfEmptyBibField{date}{%
        \IfEmptyBibField{year}{\BibField{status}}{\bib@year}%
    }{%
        \bib@year
    }%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\BibSpec{article}{%
    +{}  {\PrintAuthors}                {author}
  %  +{,} { }                     {title}
  %  +{.} { }                            {part}
 %   +{:} { \textit}                     {subtitle}
 %   +{,} { \PrintContributions}         {contribution}
 %   +{.} { \PrintPartials}              {partial}
    +{,} { \textit}                            {journal}
    +{}  { \PrintDateB}                {date}
    +{,}  { \textit}                     {volume}
    +{} {\issuetext}                  {number}
    +{, } {\eprintpages}                {pages}
    +{,} { \PrintDOI}                   {doi}
 +{,} { }                            {status}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{partial}{%
    +{}  {}                             {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {journal}
    +{}  { \textbf}                     {volume}
    +{}  { \PrintDatePV}                {date}
    +{,} { \issuetext}                  {number}
    +{,} { \eprintpages}                {pages}
}

\BibSpec{contribution}{%
    +{} {}                             {type}
    +{} { by \PrintNameList}           {author}
}

\BibSpec{book}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {publisher}
    +{,} { }                            {address}
    +{,} { }                            {organization}
    +{ } { \PrintDateB}                 {date}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{;} { \PrintDateB}                 {date}
    +{:} {}                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{conference}{%
    +{}  {}                        {title}
    +{}  {\PrintConferenceDetails} {transition}
}


\BibSpec{proceedings}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { }                     {title}
    +{,} { \textit }            {conference}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{.} { }                            {publisher}
    +{} { }                            {organization}
    +{,} { }                            {address}
    +{;} { \PrintDateB}                  {date}
    +{:} {}                            {pages}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}


\BibSpec{innerbook}{%
    +{} { }                            {subtitle}
    +{,} { }                            {part}
    +{,} { in \textit}                   {title}
    +{,}  { \PrintEditorsD}        {editor}
    +{.} { \PrintEdition}               {edition}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{,} { }                            {organization}
    +{,} { }                            {publisher}
%    +{;} { \bookchapeprintpages}         {pages}
    +{,} { }                            {address}
    +{} { \bookchapeprintpages}         {pages}
%    +{;} { \bf\PrintDateB}                 {date}
    +{.} { }                            {note}
}


\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{.} { }           {number}
    +{,} { }                            {series}
    +{,} { }                            {address}
    +{:} { }                            {organization}
    +{;} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { }                     {title}
    +{:} { \textit}                     {subtitle}
    +{.} { \it \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \PrintDateB}                 {date}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}





\BibSpec{collection.article}{%
    +{}  {\PrintAuthors}                {author}
    +{.} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{}  {\PrintBook}                   {book}
    +{,} { }                            {booktitle}
    +{,} { pp.~}                        {pages}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{,} { available at \eprint}        {eprint}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{.} { \PrintDate}                  {date}
    +{.} { \textit}                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { Technical Report }           {number}
    +{,} { }                            {series}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\BibSpec{thesis}{%
    +{}  {\PrintAuthors}                {author}
    +{} { \PrintDate}                  {date}
    +{,} {\bibquote }                             {title}
    +{,} { }                             {subtitle}
    +{,} { \PrintThesisType}            {type}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\BibSpec{incollection}{%
    +{}  {\PrintAuthors}                {author}
%    +{,} { }                      {title}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \PrintConference}            {conference}
    +{,} {In \PrintEditorsA}              {editor}
    +{}  { \PrintBook}                   {book}
    +{} { \PrintDateB}                  {date}
    +{,} { \bookchapeprintpages}         {pages}
    +{,} { }                            {booktitle}
    +{}  { }                            {address}
    +{:} { }                            {publisher}
    +{,} { }                            {status}
    +{,} { \PrintDOI}                   {doi}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}
\BibSpec{proceedings}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { }                     {title}
    +{,} { }            {conference}
    +{.} { }                            {part}
    +{:} { \textit}                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{}  { \PrintEditorsB}              {editor}
    +{,} { \PrintTranslatorsC}          {translator}
    +{,} { \PrintContributions}         {contribution}
    +{,} { }                            {series}
    +{,} { \voltext}                    {volume}
    +{.} { }                            {publisher}
    +{} { }                            {organization}
    +{,} { }                            {address}
    +{} { \PrintDateB}                  {date}
    +{,} { }                            {pages}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}
\BibSpec{report}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { }                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \textit}           {number}
    +{,} { }                            {series}
    +{,} { }                            {organization}
    +{,} { }                            {address}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{} { \PrintDateB}                  {date}
    +{.} { }                            {note}
    +{.} {}                             {transition}
    +{}  {\SentenceSpace \PrintReviews} {review}
}
\BibSpec{misc}{%
    +{}  {\PrintPrimary}                {transition}
    +{,} { }                     {title}
    +{,} { }                            {part}
    +{,} { }                     {subtitle}
    +{,} { \PrintEdition}               {edition}
    +{,} { \PrintContributions}         {contribution}
    +{,} { \reportnumber    }           {number}
    +{,} { }                            {series}
    +{,} { }                            {address}
    +{:} { }                            {organization}
    +{,} { \eprint}                     {eprint}
    +{,} { }                            {status}
    +{}  { \parenthesize}               {language}
    +{}  { \PrintTranslation}           {translation}
    +{;} { \PrintReprint}               {reprint}
    +{,} { }                            {note}
    +{} {}                             {transition}
    +{,} { \PrintDateB}                  {date}
    +{}  {\SentenceSpace \PrintReviews} {review}
}

\else%
\fi\fi\fi\fi\fi%


%
%% Macros for Scheme %%
%
\def\ftype@scheme{1}%
\def\ext@scheme{los}%
\def\fps@scheme{tbp}%
\newcounter{scheme}%
\setcounter{scheme}{0}%
\renewcommand{\thescheme}{\@arabic\c@scheme}%
\newenvironment{scheme}%
               {\@float{scheme}}%
               {\end@float}
\newenvironment{scheme*}%
               {\@dblfloat{scheme}}%
               {\end@dblfloat}
%
%% Macros for display equations %%

\let\SplitEq\relax%

\setlength\arraycolsep{2\p@}%
\setlength\tabcolsep{6\p@}%
\setlength\arrayrulewidth{.4\p@}%
\setlength\doublerulesep{4\p@}%
\setlength\tabbingsep{\labelsep}%

\def\eqnarray{%%\initialset%%%introduced on 31Oct15%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering%
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel% for centered equations
%%     \hskip\z@skip\hfil$\displaystyle\tabskip\z@skip{##}$\@eqnsel% for left aligned equations
      &\global\@eqcnt\@ne\hskip \tw@\arraycolsep \hfil${##}$\hfil
      &\global\@eqcnt\tw@ \hskip \tw@\arraycolsep
         $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
       \tabskip\z@skip
      \cr
}
\def\endeqnarray{%
      \@@eqncr
      \egroup
      \global\advance\c@equation\m@ne
   $$\@ignoretrue
}
%

%

%% Macros for Tables %%

\RequirePackage{booktabs}%

%%%%table notes%%%%
\newenvironment{tablenotes}{\list{}{\setlength{\labelsep}{0pt}% 
\setlength{\labelwidth}{0pt}%
\setlength{\leftmargin}{0pt}%
\setlength{\rightmargin}{0pt}%
\setlength{\topsep}{2pt}%
\setlength{\itemsep}{0pt}%
\setlength{\partopsep}{0pt}%
\setlength{\listparindent}{0em}%
\setlength{\parsep}{0pt}}%
\item\relax%
}{\endlist}%

\def\tnote#1{#1}%%

%

%
%\renewenvironment{sidewaystable*}
%               {\@rotdblfloat{table}}
%               {\thisfloatpagestyle{headings}\end@rotdblfloat}%

%\renewenvironment{sidewaysfigure*}
%               {\@rotdblfloat{figure}}
%               {\thisfloatpagestyle{headings}\end@rotdblfloat}

%% Macros for Quote %%

\renewenvironment{quote}{\list{}{\setlength{\labelsep}{0pt}% 
\setlength{\labelwidth}{0pt}%
\setlength{\leftmargin}{\parindentvalue}%
\setlength{\rightmargin}{\parindentvalue}%
\setlength{\topsep}{12.5pt \@plus2pt \@minus1pt}% 
\setlength{\itemsep}{0pt}%
\setlength{\partopsep}{0pt}%
\setlength{\listparindent}{0em}%
\setlength{\parsep}{0pt}}%
\def\rightline##1{\undefined\vspace*{6pt}\@@line{\hss##1}}%
\item\relax%
}{\endlist}%

%%
%%%% Enunciations: Theorem-like styles %%
%%

\let\iint\undefined%
\let\iiint\undefined%
\let\iiiint\undefined%
\let\dddot\undefined%
\let\ddddot\undefined%
\let\overleftrightarrow\undefined%
\let\underrightarrow\undefined%
\let\underleftarrow\undefined%
\let\underleftrightarrow\undefined%

\RequirePackage[intlimits,sumlimits,namelimits,centertags]{amsmath}%

\@ifpackageloaded{amsmath}{%
%%
\def\extrap@#1{%
 \DN@{#1}%% \DN@{#1\,}%% THIN SPACE PURPOSELY COMMENTED 
 \ifx\@let@token,\else
 \ifx\@let@token;\else
 \ifx\@let@token.\else\extra@
 \ifgtest@\else
 \let\next@#1\fi\fi\fi\fi\next@}
%%
\renewcommand{\iint}{\DOTSI\protect\MultiIntegral{2}}
\renewcommand{\iiint}{\DOTSI\protect\MultiIntegral{3}}
\renewcommand{\iiiint}{\DOTSI\protect\MultiIntegral{4}}
%%
\renewcommand{\dddot}[1]{%
  {\mathop{#1}\limits^{\vbox to-1.4\ex@{\kern-\tw@\ex@
   \hbox{\normalfont ...}\vss}}}}
\renewcommand{\ddddot}[1]{%
  {\mathop{#1}\limits^{\vbox to-1.4\ex@{\kern-\tw@\ex@
   \hbox{\normalfont....}\vss}}}}
%%
\renewcommand{\smash}[1][tb]{}%
%%
\renewcommand{\overleftrightarrow}{%
  \mathpalette{\overarrow@\leftrightarrowfill@}}
%%
\renewcommand{\underrightarrow}{%
  \mathpalette{\underarrow@\rightarrowfill@}}
\renewcommand{\underleftarrow}{%
  \mathpalette{\underarrow@\leftarrowfill@}}
\renewcommand{\underleftrightarrow}{%
  \mathpalette{\underarrow@\leftrightarrowfill@}}
%%
\c@MaxMatrixCols=20%
%%
\def\black@#1{%
\ifdim#1>\linewidth\relax%
\errmessage{*********EQUATION EXCEEDS TEXT WIDTH*******}%
\fi%
    \noalign{%
        \ifdim#1>\displaywidth
            \dimen@\prevdepth
            \nointerlineskip
            \vskip-\ht\strutbox@
            \vskip-\dp\strutbox@
            \vbox{\noindent\hbox to#1{\strut@\hfill}}%
            \prevdepth\dimen@
        \fi
    }%
}
%%
\def\gather@#1{%
    \ingather@true \let\split\insplit@
    \let\tag\tag@in@align \let\label\label@in@display
    \chardef\dspbrk@context\z@
    \intertext@ \displ@y@ \Let@
    \let\math@cr@@@\math@cr@@@gather
    \gmeasure@{#1}%
    \global\shifttag@false
    \tabskip\z@skip
    \global\row@\@ne
    \halign to\displaywidth\bgroup
        \strut@
        \setboxz@h{$\m@th\displaystyle{##}$}%
        \calc@shift@gather
        \set@gather@field
        \tabskip\@centering
       &\setboxz@h{\strut@{##}}%
        \place@tag@gather
        \tabskip \iftagsleft@ \gdisplaywidth@ \else \z@skip \span\fi
        \crcr
%%      #1% Default
        \normalbaselines#1% 
}
%%
}{}

\@ifpackageloaded{amsopn}{%
\def\stixoperator@font{\mathgroup\symtextcomp}
\def\stixoperatorfont{\let\operator@font\stixoperator@font}%
\def\arccos{\stixoperatorfont\qopname\relax o{arccos}}
\def\arcsin{\stixoperatorfont\qopname\relax o{arcsin}}
\def\arctan{\stixoperatorfont\qopname\relax o{arctan}}
\def\arg{\stixoperatorfont\qopname\relax o{arg}}
\def\cos{\stixoperatorfont\qopname\relax o{cos}}
\def\cosh{\stixoperatorfont\qopname\relax o{cosh}}
\def\cot{\stixoperatorfont\qopname\relax o{cot}}
\def\coth{\stixoperatorfont\qopname\relax o{coth}}
\def\csc{\stixoperatorfont\qopname\relax o{csc}}
\def\deg{\stixoperatorfont\qopname\relax o{deg}}
\def\det{\stixoperatorfont\qopname\relax m{det}}
\def\dim{\stixoperatorfont\qopname\relax o{dim}}
\def\exp{\stixoperatorfont\qopname\relax o{exp}}
\def\gcd{\stixoperatorfont\qopname\relax m{gcd}}
\def\hom{\stixoperatorfont\qopname\relax o{hom}}
\def\inf{\stixoperatorfont\qopname\relax m{inf}}
\def\injlim{\stixoperatorfont\qopname\relax m{inj\,lim}}
\def\ker{\stixoperatorfont\qopname\relax o{ker}}
\def\lg{\stixoperatorfont\qopname\relax o{lg}}
\def\lim{\stixoperatorfont\qopname\relax m{lim}}
\def\liminf{\stixoperatorfont\qopname\relax m{lim\,inf}}
\def\limsup{\stixoperatorfont\qopname\relax m{lim\,sup}}
\def\ln{\stixoperatorfont\qopname\relax o{ln}}
\def\log{\stixoperatorfont\qopname\relax o{log}}
\def\max{\stixoperatorfont\qopname\relax m{max}}
\def\min{\stixoperatorfont\qopname\relax m{min}}
\def\Pr{\stixoperatorfont\qopname\relax m{Pr}}
\def\projlim{\stixoperatorfont\qopname\relax m{proj\,lim}}
\def\sec{\stixoperatorfont\qopname\relax o{sec}}
\def\sin{\stixoperatorfont\qopname\relax o{sin}}
\def\sinh{\stixoperatorfont\qopname\relax o{sinh}}
\def\sup{\stixoperatorfont\qopname\relax m{sup}}
\def\tan{\stixoperatorfont\qopname\relax o{tan}}
\def\tanh{\stixoperatorfont\qopname\relax o{tanh}}
\def\operator@font{\mathgroup\symoperators}
}{}%

\RequirePackage{amsthm}

\newif\ifeproof%

%%introduced to make number in italics
%\def\thmhead@plain#1#2#3{%
%  \thmname{#1}\ifeproof\else\thmnumber{\@ifnotempty{#1}{ }\textit{#2}}%
%  \thmnote{ {\the\thm@notefont\textit{(#3)}}}\fi}

%\newtheorem{theorem}{Theorem}
%\newtheorem{lemma}{Lemma}
%\newtheorem{proposition}{Proposition}
%\newtheorem{definition}{Definition}
%\newtheorem{corollary}{Corollary}
%\newtheorem{conjecture}{Conjecture}
%\newtheorem{eremark}{Remark}
%\newtheorem{case}{Case}
%\newtheorem{eexample}{Example}
%\newtheorem{estep}{Step}
%\newtheorem{eproof}{Proof}
\def\thm@space@setup{%
  \thm@preskip=7\p@ \thm@postskip=7\p@
}
\thm@headpunct{}

\def\thmsep{9pt}%

\newtheoremstyle{plain}% Numbered
{8pt}% Space above
{8pt}% Space below
{\normalfont}% Body font
{}% Indent amount
{\itshape}% Theorem head font
{}% Punctuation after theorem head
{\newline}% Space after theorem headi
{}% Theorem head spec (can be left empty, meaning `normal')

%\renewenvironment{proof}[1][\proofname]{\par%
%\pushQED{\qed}%
%  \pushQED{\fontsize{9}{0}\selectfont{\qed}}%
%\pushQED{\hfill\fontsize{9}{0}\selectfont{$\square$}}%
%  \normalfont \topsep8\p@\@plus6\p@\relax
%  \noindent\ignorespaces{\itshape#1}\newline%\itshape
%}{%
%\popQED\endtrivlist\@endpefalse
%}
%

\newtheoremstyle{WBstyleone}
  {6\p@} % Space above
  {6\p@} % Space below
  {\itshape\everymath{\rm}\let\text\mathrm} % Body font
  {\z@} % Indent amount
  {\bfseries} % Theorem head font
  {.} % Punctuation after theorem head
  {5\p@} % Space after theorem head
  {} % Theorem head spec (can be left empty, meaning `normal')

\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \bfseries
    #1\@addpunct{.}]\ignorespaces
\itshape}{%\vspace*{-\baselineskip}%
  \popQED\endtrivlist\@endpefalse
}


\newtheoremstyle{WBstyletwo}
  {6\p@} % Space above
  {6\p@} % Space below
  {\normalfont\itshape\everymath{\rm}\let\text\mathrm} % Body font
  {\z@} % Indent amount
  {\bfseries} % Theorem head font
  {.} % Punctuation after theorem head
  {5\p@} % Space after theorem head
  {\thmname{#1}\thmnumber{ #2}\thmnote{. #3}} % Theorem head spec (can be left empty, meaning `normal')
  
\newtheoremstyle{WBstylethree}
  {6\p@} % Space above
  {6\p@} % Space below
  {\normalfont\itshape\everymath{\rm}\let\text\mathrm} % Body font
  {\z@} % Indent amount
  {\bfseries} % Theorem head font
  {.} % Punctuation after theorem head
  {5\p@} % Space after theorem head
  {} % Theorem head spec (can be left empty, meaning `normal')

\theoremstyle{WBstyleone}
\newtheorem{theorem}{Theorem}
\newtheorem{property}{Property}
\newtheorem{problem}{Problem}
\newtheorem{fact}{Fact}
\newtheorem{construction}{Construction}
\newtheorem{estimate}{Estimate}
\newtheorem{case}{Case}
\newtheorem{lemma}{Lemma}
\newtheorem{corollary}{Corollary}
\newtheorem{result}{Result}
\newtheorem{algth}{Algorithm}
\newtheorem{proposition}{Proposition}
\newtheorem{condition}{Condition}
\newtheorem{hypothesis}{Hypothesis}
\newtheorem{model}{Model}
\newtheorem{experiment}{Experiment}

\theoremstyle{WBstyletwo}
\newtheorem{remark}{Remark}
\newtheorem{example}{Example}
\newtheorem{assumption}{Assumption}

\theoremstyle{WBstylethree}
\newtheorem{definition}{Definition}



%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cropping pdf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\newdimen\CP@toff@wd
\newdimen\CP@toff@ht
%
\newdimen\CP@boff@wd
\newdimen\CP@boff@ht
%
\newdimen\CP@crop@wd
\newdimen\CP@crop@ht
%
\newdimen\CP@bled@wd
\newdimen\CP@bled@ht
%
\newdimen\CP@trim@wd
\newdimen\CP@trim@ht
%
\def\str@yes{yes}
\def\SetCrop#1#2{%
    \gdef\IsCropSet{yes}
    \global\CP@crop@wd=#1\relax
    \global\CP@crop@ht=#2\relax}
\def\SetTrim#1#2{%
    \gdef\IsTrimSet{yes}
    \global\CP@trim@wd=#1\relax
    \global\CP@trim@ht=#2\relax}
\def\SetBleed#1#2{%
    \gdef\IsBleedSet{yes}
    \global\CP@bled@wd=#1\relax
    \global\CP@bled@ht=#2\relax}
%
\everyjob\expandafter{%
    \the\everyjob
    \typeout{%
        \filename\space <\filedate>^^J
        Version: v\fileversion^^J
        LaTeX macros for setting Page Box parameters
    }%
  \IfFileExists{\filename.cfg}{%
        \begingroup\@@input\@filef@und\endgroup
    }{%
        \typeout{No File: \filename.cfg}%
    }%
  \IfFileExists{\jobname.cfg}{%
        \begingroup\@@input\@filef@und\endgroup
    }{%
        \typeout{No File: \jobname.cfg}%
    }%
}
%
\SetCrop{600pt}{800pt}%{8.33in}{11.11in}% provided reduced value to get actual trim in PDF output
\SetTrim{600pt}{800pt}%{8.33in}{11.11in}% provided reduced value to get actual trim in PDF output
\SetBleed{0pt}{0pt}
%
\def\do@pagebox@calc{%
    \CP@toff@wd=\CP@crop@wd
    \advance\CP@toff@wd     by -\CP@trim@wd
    \divide\CP@toff@wd  by \tw@
%
    \CP@toff@ht=\CP@crop@ht
    \advance\CP@toff@ht     by -\CP@trim@ht
    \divide\CP@toff@ht  by \tw@
%
    \advance\CP@trim@wd     by \CP@toff@wd
    \advance\CP@trim@ht     by \CP@toff@ht
%
    \CP@boff@wd=\CP@toff@wd
    \advance\CP@boff@wd     by -\CP@bled@wd
%
    \CP@boff@ht=\CP@toff@ht
    \advance\CP@boff@ht     by -\CP@bled@ht
%
    \advance\CP@bled@wd     by \CP@trim@wd
    \advance\CP@bled@ht     by \CP@trim@ht
}
%
\def\pdf@page@parameters{%
    \ifx\IsCropSet\str@yes
        [{ThisPage} << /CropBox [0 0 \strip@pt\CP@crop@wd\space \strip@pt\CP@crop@ht] >> /PUT pdfmark
        [{ThisPage} << /MediaBox[0 0 \strip@pt\CP@crop@wd\space \strip@pt\CP@crop@ht] >> /PUT pdfmark
    \fi
    \ifx\IsTrimSet\str@yes
        [{ThisPage} << /TrimBox [\strip@pt\CP@toff@wd\space \strip@pt\CP@toff@ht\space \strip@pt\CP@trim@wd\space \strip@pt\CP@trim@ht] >> /PUT pdfmark
    \fi
    \ifx\IsBleedSet\str@yes
        [{ThisPage} << /BleedBox[\strip@pt\CP@boff@wd\space \strip@pt\CP@boff@ht\space \strip@pt\CP@bled@wd\space \strip@pt\CP@bled@ht] >> /PUT pdfmark
    \fi
%       [{ThisPage} << /ArtBox [0 0 595 842] >> /PUT pdfmark
}
%
\def\shipout@PageObjects{%
    \special{ps: \pdf@page@parameters}%
}
%%
\AtBeginDocument{%
    \do@pagebox@calc
    \let\org@begindvi\@begindvi
    \def\@begindvi{%
        \shipout@PageObjects
        \org@begindvi
        \global\let\@begindvi\rest@dvi@pages
    }%
}
\let\rest@dvi@pages\shipout@PageObjects

%% Macros for spanned equations %%

\def\eqnopnrule{\par\vspace*{-6pt}\rule{\columnhsizevalue}{1pt}}%
\def\eqnclsrule{\par\hbox{\hskip\columnhsizevalue\hskip\columnsep\rule{\columnhsizevalue}{1pt}}\vspace*{6pt}}%


%
%% Macros for Appendix %%
%
\newif\ifappendixsec%
\def\appendix{\global\appendixsectrue\printjnlcitation%
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \setcounter{subsubsection}{0}%
  \setcounter{figure}{0}%
  \setcounter{table}{0}%
  \setcounter{equation}{0}%
  \renewcommand\thesection{APPENDIX\ \@Alph\c@section}%
  \renewcommand\thesubsection{\@Alph\c@section.\@arabic\c@subsection}%
  \renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}%
  \renewcommand\thefigure{\@Alph\c@section\arabic{figure}}%
  \renewcommand\thetable{\@Alph\c@section\arabic{table}}%
  \renewcommand\theequation{\@Alph\c@section\arabic{equation}}%
}%
%
%
%%% Macros for float algorithm %%%

%\usepackage[plain]{algorithm} %% wrapper
%\usepackage{varwidth}%
%\usepackage{algorithmicx}%
%\usepackage{algpseudocode}%
\usepackage{algorithm, algorithmicx, algpseudocode}

\usepackage{listings}%
\usepackage{alltt}%


%%% Macros for upright lowercase greek characters %%%


%% since small triangle symbol is not found used \triangleright and rotated to 90 degrees %%


\def\@jissue{}%
\def\jissue#1{\gdef\@jissue{#1}}%

\def\@licenseVal{}%
\def\licenseVal#1{\gdef\@licenseVal{#1}}%

\def\@supplinks{}%
\def\supplinks#1{\gdef\@supplinks{#1}}%

\def\@coninterest{}%
\def\coninterest#1{\gdef\@coninterest{#1}}%

\def\@confinfo{}%
\def\confinfo#1{\def\@confinfo{#1}}%

\def\@cdate{}%
\def\cdate#1{\gdef\@cdate{#1}}%

\def\@cname{}%
\def\cname#1{\gdef\@cname{#1}}%

\def\@cloc{}%
\def\cloc#1{\gdef\@cloc{#1}}%

\def\tabheadfont{}%

\let\fullpagewidth\textwidth%

\def\jargon#1{#1}%

\newenvironment{bm}[1][]{\begingroup%
\if!#1!\else\section*{#1}\fi%
}{\endgroup}

\let\glosslist\description%
\let\endglosslist\enddescription%

\newenvironment{ack}[1][]{\begingroup%
\if!#1!\else\section*{#1}\fi%
}{\endgroup}

\def\APLrightarrowbox{}% Use \usepackage{wasysym} to get this symbol
\def\boxcircle{}%

%% Macros for \citation tag %%

\newbox\jnlcitationbox%

\def\cname#1{\gdef\author##1{##1}#1}%
\def\cyear#1{#1}%
\def\ctitle#1{#1}%
\def\cjournal#1{\textit{#1}}%
\def\cvol#1{\textit{#1}}%

\gdef\@jnlcitation{}%
\def\jnlcitation#1{\gdef\@jnlcitation{\textbf{How cite this article: }#1}}%

\newdimen\jnlcithsize%
\jnlcithsize=\textwidth%
\advance\jnlcithsize-12pt% fbox sep x 2
\advance\jnlcithsize-1pt% fbox rule x 2

\gdef\printjnlcitation{\removelastskip\vskip18pt\fboxsep=6pt\fboxrule=0.5pt%
\hskip-\parindentvalue\fbox{\vbox{\noindent\hsize\jnlcithsize\@jnlcitation}}}%

\AtEndDocument{\ifappendixsec\else\printjnlcitation\fi}%

%% Misc math macros %%

\newcommand{\xleftrightarrow}[2][]{\ext@arrow 3399\leftrightarrowfill@{#1}{#2}}%

%
%%% Macros for Biography %%%
%
\RequirePackage{wrapfig}%
%
%  \begin{wrapfigure}[12]{r}[34pt]{5cm} <figure> \end{wrapfigure}
%                     --  -  ----  ---
%  [number of narrow lines] {placement} [overhang] {width of figure}
\newcount\wraplines%
\wraplines=5%
%
\newbox\@authorfigbox%
\newskip\@authorfigboxdim%
%

\newskip\biofigadjskip%
\biofigadjskip=0pt%
%
\newenvironment{biography}[2]{\par\addvspace{10.5pt plus3.375pt minus1.6875pt}%\lineno@off%
\def\author##1{\textbf{##1}}%
\def\@authorfig{{#1}}%
\setbox\@authorfigbox=\hbox{#1}%%10Nov16%%
\@authorfigboxdim=\wd\@authorfigbox%
%14pt%
\noindent{%
\ifx\@authorfig\@empty\else\unskip%
\begin{wrapfigure}[\wraplines]{l}[0pt]{\@authorfigboxdim}%{38.25mm}%
\vskip-25pt\vskip\biofigadjskip%
\@authorfig%
\end{wrapfigure}%
\fi%
#2%
\par%
}}{\par\addvspace{10.5pt plus3.375pt minus1.6875pt}}


%%% Macros for Bibliography %%%


\endinput


