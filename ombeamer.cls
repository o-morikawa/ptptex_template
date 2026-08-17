%%
%% ombeamer.cls
%% Personal Beamer class for Okuto Morikawa.
%% Updated: 2026-08-18 00:10 JST
%%
%% Examples:
%%   \documentclass[12pt,lang=en]{ombeamer}
%%   \documentclass[12pt,lang=en,cjk]{ombeamer}
%%   \documentclass[12pt,lang=jp]{ombeamer}
%%   \documentclass[12pt,lang=en,sectiontoc]{ombeamer}
%%   \documentclass[poster,lang=en]{ombeamer}
%%   \documentclass[poster,lang=jp]{ombeamer}
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ombeamer}[2026/08/18 OM personal Beamer class]

%% ------------------------------------------------------------
%% Class options
%% ------------------------------------------------------------

\newif\ifombeamer@japanese
\newif\ifombeamer@cjk
\newif\ifombeamer@sectiontoc
\newif\ifombeamer@poster
\newif\ifombeamer@showcomments
\newif\ifombeamer@showrevision

\ombeamer@japanesefalse
\ombeamer@cjkfalse
\ombeamer@sectiontocfalse
\ombeamer@posterfalse
\ombeamer@showcommentsfalse
\ombeamer@showrevisionfalse

\DeclareOption{lang=en}{\ombeamer@japanesefalse}
\DeclareOption{lang=jp}{\ombeamer@japanesetrue}

\DeclareOption{cjk}{\ombeamer@cjktrue}
\DeclareOption{nocjk}{\ombeamer@cjkfalse}

\DeclareOption{sectiontoc}{\ombeamer@sectiontoctrue}
\DeclareOption{nosectiontoc}{\ombeamer@sectiontocfalse}

\DeclareOption{poster}{\ombeamer@postertrue}
\DeclareOption{noposter}{\ombeamer@posterfalse}

\DeclareOption{comments}{\ombeamer@showcommentstrue}
\DeclareOption{nocomments}{\ombeamer@showcommentsfalse}

\DeclareOption{revision}{\ombeamer@showrevisiontrue}
\DeclareOption{norevision}{\ombeamer@showrevisionfalse}

%% All other options, such as 12pt, are Beamer options.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

%% These options are controlled by ombeamer itself.
\PassOptionsToClass{usepdftitle=false}{beamer}
\ifombeamer@poster
  %% Poster preset: equivalent to t, final, and the old mathserif
  %% behavior.  mathserif itself is obsolete in current Beamer, so the
  %% equivalent font theme is selected below.
  \PassOptionsToClass{t,final}{beamer}
\fi
\ifombeamer@japanese
  %% Beamer loads geometry before it processes its own options.  Therefore
  %% dvipdfmx must also be visible as a global class option, exactly as if
  %% the user had written it in \documentclass[...,dvipdfmx]{beamer}.
  \g@addto@macro\@classoptionslist{,dvipdfmx}%
  \g@addto@macro\@unusedoptionlist{,dvipdfmx}%
  \PassOptionsToPackage{dvipdfmx}{xcolor}%
\fi

\LoadClass{beamer}

%% ------------------------------------------------------------
%% Language-dependent setup
%% ------------------------------------------------------------

\ifombeamer@japanese
  \RequirePackage{pxjahyper}
  \RequirePackage{minijs}
  \renewcommand{\kanjifamilydefault}{\gtdefault}
\fi

\ifombeamer@cjk
  \ifombeamer@japanese
    \ClassWarning{ombeamer}{Option `cjk' is intended for lang=en; it is ignored in lang=jp}
  \else
    \RequirePackage{CJKutf8}

    %% Public font-family names: users may redefine these in the preamble.
    \newcommand{\jpminchofont}{ipxm}
    \newcommand{\jpgothicfont}{ipxg}

    \newcommand{\jp}[1]{%
      \begin{CJK*}{UTF8}{\jpminchofont}#1\end{CJK*}%
    }
    \newcommand{\Jp}[1]{%
      \begin{CJK*}{UTF8}{\jpgothicfont}#1\end{CJK*}%
    }
  \fi
\fi

%% ------------------------------------------------------------
%% Standard Beamer / poster setup
%% ------------------------------------------------------------

\ifombeamer@poster
  \mode<presentation>{%
    \usetheme{Madrid}%
  }
  \usefonttheme[onlymath]{serif}
  \RequirePackage[
    orientation=portrait,
    size=a0,
    scale=1.4,
    debug
  ]{beamerposter}
\else
  \usetheme{Boadilla}
\fi
\setbeamertemplate{navigation symbols}{}

%% ------------------------------------------------------------
%% Common packages
%% ------------------------------------------------------------

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{mathtools}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{bm}
\RequirePackage{etoolbox}

\RequirePackage{tikz}
\RequirePackage{booktabs}
\RequirePackage{float}
\RequirePackage{cancel}
\RequirePackage{comment}
\RequirePackage{ulem}

%% ------------------------------------------------------------
%% Poster-specific appearance
%% ------------------------------------------------------------

\ifombeamer@poster
  %% These reproduce the defaults used in the former poster preamble.
  %% They can still be overwritten later in the document preamble.
  \setbeamerfont{normal text}{size=\large}
  \setbeamerfont{caption}{size=\normalsize}
  \setbeamerfont{title}{size=\Huge,series=\bfseries}
  \setbeamerfont{author}{size=\LARGE}
  \setbeamerfont{institute}{size=\Large}
  \setbeamerfont{block title}{size=\huge}
  \setbeamerfont*{itemize/enumerate body}{size=\large}
  \setbeamerfont*{itemize/enumerate subbody}{
    parent=itemize/enumerate body,
    size=\large
  }
  \setbeamerfont*{itemize/enumerate subsubbody}{
    parent=itemize/enumerate subbody,
    size=\large
  }

  \setbeamercolor{block body}{bg=white!100}
  \setbeamercolor{block body example}{bg=green!0.5}
  \setbeamercolor{block body alerted}{bg=red!0.5}

  %% Poster dates are blank by default; a later \date{...} overwrites this.
  \date{}
  \AtBeginDocument{\thispagestyle{empty}}
\fi

%% ------------------------------------------------------------
%% Poster page helper
%% ------------------------------------------------------------

%% Default width of each column in \Poster.
%% Users may redefine this in the preamble if desired, e.g.
%%   \renewcommand{\postercolumnwidth}{0.48\columnwidth}
\newcommand{\postercolumnwidth}{0.494\columnwidth}

%% \Poster{<left column>}{<right column>}
%%
%% In poster mode this expands to
%%   frame -> \maketitle -> columns -> left/right columns.
%% Paragraph breaks are allowed in both arguments.
\NewDocumentCommand{\Poster}{+m +m}{%
  \ifombeamer@poster
    \begin{frame}%
      \maketitle
      \begin{columns}%
        \begin{column}{\postercolumnwidth}%
          #1%
        \end{column}%
        \begin{column}{\postercolumnwidth}%
          #2%
        \end{column}%
      \end{columns}%
    \end{frame}%
  \else
    \ClassError{ombeamer}{\string\Poster\space is available only in poster mode}{%
      Add the `poster' option to \string\documentclass, or use an ordinary
      Beamer frame instead.%
    }%
  \fi
}

%% ------------------------------------------------------------
%% Title, author, affiliation, and PDF metadata
%% ------------------------------------------------------------

%% Public metadata values.  The helper commands below update them.
\newcommand{\pdfmetatitle}{}
\newcommand{\pdfmetasubject}{}
\newcommand{\pdfmetaauthor}{Okuto Morikawa}
\newcommand{\pdfmetadate}{}
\newcommand{\pdfmetadateshort}{}
\newcommand{\pdfmetakeywords}{Last updated on \today}

%% \Maintitle[Short title]{Full title}
%% sets both the Beamer title and the PDF metadata title.
\NewDocumentCommand{\Maintitle}{o m}{%
  \gdef\pdfmetatitle{#2}%
  \IfNoValueTF{#1}{%
    \title{#2}%
  }{%
    \title[#1]{#2}%
  }%
}

%% \Subject{Subject}
%% sets the PDF metadata subject.
\NewDocumentCommand{\Subject}{m}{%
  \gdef\pdfmetasubject{#1}%
}

%% \Author[Short author]{Full author}
%% sets both the Beamer author and the PDF metadata author.
\NewDocumentCommand{\Author}{o m}{%
  \gdef\pdfmetaauthor{#2}%
  \IfNoValueTF{#1}{%
    \author{#2}%
  }{%
    \author[#1]{#2}%
  }%
}

%% \Date[Short date]{Full date}
%% sets the Beamer date and stores both full and short forms.
\NewDocumentCommand{\Date}{o m}{%
  \gdef\pdfmetadate{#2}%
  \IfNoValueTF{#1}{%
    \gdef\pdfmetadateshort{#2}%
    \date{#2}%
  }{%
    \gdef\pdfmetadateshort{#1}%
    \date[#1]{#2}%
  }%
}

%% \Affil[Short affiliation]{Full affiliation}
%% sets the Beamer institute.  In normal slide mode, the full
%% affiliation is displayed in \small, as in the former \affil helper.
\NewDocumentCommand{\Affil}{o m}{%
  \IfNoValueTF{#1}{%
    \ifombeamer@poster
      \institute[#2]{#2}%
    \else
      \institute[#2]{{\small #2}}%
    \fi
  }{%
    \ifombeamer@poster
      \institute[#1]{#2}%
    \else
      \institute[#1]{{\small #2}}%
    \fi
  }%
}

%% Backward-compatible lowercase alias.
\let\affil\Affil

\AtEndPreamble{%
  \hypersetup{%
    pdftitle={\pdfmetatitle},%
    pdfsubject={\pdfmetasubject},%
    pdfauthor={\pdfmetaauthor},%
    pdfkeywords={\pdfmetakeywords},%
    pdfborder={0 0 1},%
    allbordercolors={structure!60},%
    urlbordercolor={0 1 0}%
  }%
}

%% ------------------------------------------------------------
%% Section table of contents
%% ------------------------------------------------------------

\ifombeamer@sectiontoc
  \ifombeamer@poster
    \ClassWarning{ombeamer}{Option `sectiontoc' is ignored in poster mode}
  \else
    \AtBeginSection[]{%
      \begin{frame}{}
        \tableofcontents[currentsection]
      \end{frame}%
    }
  \fi
\fi

%% ------------------------------------------------------------
%% Backup frame numbering
%% ------------------------------------------------------------

\newcounter{framenumberappendix}

\newcommand{\backupbegin}{%
  \setcounter{framenumberappendix}{\value{framenumber}}%
}

\newcommand{\backupend}{%
  \addtocounter{framenumberappendix}{-\value{framenumber}}%
  \addtocounter{framenumber}{\value{framenumberappendix}}%
}

%% ------------------------------------------------------------
%% Colors
%% ------------------------------------------------------------

\definecolor{mygreen}{rgb}{0,0.6,0}
\setbeamercolor{black-blue}{fg=black,bg=blue!2.1}
\newcommand{\ccite}[1]{\textcolor{mygreen}{[#1]}}

%% ------------------------------------------------------------
%% Comment mode (formerly in omphys.sty)
%% ------------------------------------------------------------

\ifombeamer@showcomments
  \newcommand{\omphysCmt}[3]{\textcolor{#1}{[#2: #3]}}
\else
  \newcommand{\omphysCmt}[3]{}
\fi

\newcommand{\cmtOM}[1]{\omphysCmt{teal}{OM}{#1}}
\let\pteCmt\omphysCmt

%% ------------------------------------------------------------
%% Revision highlighting (formerly in omphys.sty)
%% ------------------------------------------------------------

\newcount\ombeamer@revisionnum
\ombeamer@revisionnum=1

\newcommand{\revisionnum}[1]{%
  \ombeamer@revisionnum=#1\relax
}

\providecommand{\pteRevColor}{magenta}

\newcommand{\rev}[2]{%
  \ifombeamer@showrevision
    \ifnum#1=\ombeamer@revisionnum
      \textcolor{\pteRevColor}{#2}%
    \else
      #2%
    \fi
  \else
    #2%
  \fi
}

\newcommand{\revone}[1]{\rev{1}{#1}}
\newcommand{\revtwo}[1]{\rev{2}{#1}}
\newcommand{\revthree}[1]{\rev{3}{#1}}

%% ------------------------------------------------------------
%% Math operators
%% ------------------------------------------------------------

\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\Tr}{Tr}
\DeclareMathOperator{\re}{Re}
\DeclareMathOperator{\im}{Im}
\DeclareMathOperator{\Arg}{Arg}
\DeclareMathOperator{\diag}{diag}
\DeclareMathOperator{\supp}{supp}
\DeclareMathOperator{\Erf}{Erf}
\DeclareMathOperator{\Erfi}{Erfi}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\Res}{Res}
\DeclareMathOperator{\ord}{ord}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\vol}{Vol}

%% ------------------------------------------------------------
%% Feynman slash
%% ------------------------------------------------------------

\newcommand{\Slash}[1]{{\ooalign{\hfil/\hfil\crcr$#1$}}}
\let\Slach\Slash

%% ------------------------------------------------------------
%% Bra-ket
%% ------------------------------------------------------------

\newcommand{\bra}[1]{\langle #1 \rvert}
\newcommand{\ket}[1]{\lvert #1 \rangle}
\newcommand{\braket}[1]{\langle #1 \rangle}

\newcommand{\Bra}[1]{\left\langle #1 \right\rvert}
\newcommand{\Ket}[1]{\left\lvert #1 \right\rangle}
\newcommand{\Braket}[1]{\left\langle #1 \right\rangle}

%% ------------------------------------------------------------
%% Blackboard bold sets
%% ------------------------------------------------------------

\newcommand{\bbN}{\mathbb{N}}
\newcommand{\bbZ}{\mathbb{Z}}
\newcommand{\bbR}{\mathbb{R}}
\newcommand{\bbC}{\mathbb{C}}
\newcommand{\bbH}{\mathbb{H}}

%% ------------------------------------------------------------
%% Roman constants
%% ------------------------------------------------------------

\newcommand{\rmi}{\mathrm{i}}
\newcommand{\rmd}{\mathrm{d}}
\newcommand{\rme}{\mathrm{e}}

%% ------------------------------------------------------------
%% Scripts and units
%% ------------------------------------------------------------

\newcommand{\vsub}[2]{#1_{\mathrm{#2}}}
\newcommand{\vsup}[2]{#1^{\mathrm{#2}}}
\newcommand{\unit}[2]{#1\,\mathrm{#2}}

%% ------------------------------------------------------------
%% Text colors
%% ------------------------------------------------------------

\newcommand{\red}[1]{\textcolor{red}{#1}}
\newcommand{\magenta}[1]{\textcolor{magenta}{#1}}
\newcommand{\cyan}[1]{\textcolor{cyan}{#1}}
\newcommand{\blue}[1]{\textcolor{blue}{#1}}
\newcommand{\teal}[1]{\textcolor{teal}{#1}}

\endinput
