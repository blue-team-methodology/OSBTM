\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{usiinfthesis}[2010/04/14 v. 1.1.2 %
 USI Informatics Doctoral Dissertation class]
%%% initial code
\RequirePackage{xifthen}
%%% true to produce a version suitable for printing
\newboolean{@printversion}
%%% true to enable automatic loading of hyperref package
\newboolean{@hypermode}
%%% true if a subtitle is provided
\newboolean{@subtitle}
%%% true if a coadvisor is provided
\newboolean{@coadvisor}
%%% true if a dedication is provided
\newboolean{@dedication}
%%% true if an epigraph is provided
\newboolean{@epigraph}
%%% true to insert a copyright notice
\newboolean{@crn}
%%% true if the document is a master thesis
\newboolean{@mscthesis}
% true if a master specialization is provided
\newboolean{@mscspec}
% true if the lulu options is provided
\newboolean{@lulu}
\DeclareOption{lulu}{%
\setboolean{@lulu}{true}
\setboolean{@crn}{true}
%\setboolean{@crn}{true}
}
%%% declaration of options
\DeclareOption{print}{\setboolean{@printversion}{true}}
  {%redefine margins to match oneside layout
  }
%%% enable/disable hyperref
\DeclareOption{hyper}{\setboolean{@hypermode}{true}}
\DeclareOption{nohyper}{\setboolean{@hypermode}{false}}
% Produces a copyright notice. Enable if PhD program director likes it.
\DeclareOption{crn}{\setboolean{@crn}{true}}
%%%
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{openany}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
%%% enable settings for a master thesis
\DeclareOption{mscthesis}{\setboolean{@mscthesis}{true}}

%%%
\DeclareOption*{% 
\PassOptionsToClass{\CurrentOption}{book}% 
} 
%%% execution of options
\ExecuteOptions{hyper}
\ProcessOptions \relax
\typeout{*** Please report bugs, comments, suggestions, and improvements
  to: }
\typeout{*** Domenico Bianculli <domenico.bianculli@usi.ch>}
\typeout{*** Jochen Wuttke <wuttkej@usi.ch>}
%%% package loading
\ifthenelse{\boolean{@lulu}}
{\LoadClass[a4paper,10pt,twoside,onecolumn,openright,titlepage]{book}}
{\LoadClass[a4paper,twoside,onecolumn,openright,titlepage]{book}}
%%% main code


%font settings
\RequirePackage[T1]{fontenc}
\RequirePackage[charter]{mathdesign}
\RequirePackage[scaled]{beramono}
\renewcommand{\sfdefault}{uop}
\renewcommand{\scshape}{%
\not@math@alphabet\scshape\relax
\ifthenelse{\equal{\f@family}{uop}}%
{\fontshape{sc}\selectfont}%
{\fontshape{fsc}\selectfont}%
}


%sans-serif titles
\RequirePackage{sectsty}
\allsectionsfont{\sffamily}

%geometry
\RequirePackage[a4paper]{geometry}
\geometry{hscale=0.66}
\ifthenelse{\boolean{@printversion}}{}%
{  \geometry{asymmetric}
  \geometry{bindingoffset=0pt,hmarginratio=1:1}
}
\ifthenelse{\boolean{@lulu}}%
{
  \renewcommand\@ptsize{0}%% set font size to 10pt
  \geometry{papersize={6in, 9in}}
  \geometry{inner=.625in, outer=.5in, top=.5in, bottom=0.75in,  
  includehead,includefoot,twoside}
}{}


%%% fancy headers
\RequirePackage{fancyhdr}
\setlength{\headheight}{15pt}
\fancypagestyle{cover}{%
  \fancyhf{}
  \fancyhead{\mbox{ }}
}
\fancypagestyle{hrulefpage}{%
  \fancyhf{}
   \fancyhead{\mbox{ }}
  \fancyfoot[C]{\sf \thepage}
}
%modifying captions
\RequirePackage[font=sf,labelsep=period]{caption}
%datatool
\RequirePackage{datatool}
\RequirePackage{calc}

%commands to print empty values in the database 
\newcommand{\print@blank}[1]{\ifthenelse{\equal{#1}{!blank!}}{}{#1\ }}
\newcommand{\print@empty}[1]{\ifthenelse{\equal{#1}{!blank!}}{}{#1}}
%%% populate the committee database
%%% format of the rows (name of the columns in brackets) :
%%% Title [title], First and Middle [first], Last [last], Affiliation
%%% [aff], Type ([a]dvisor, [c]oadvisor, [e]xternal, [i]nternal) [type]
\newenvironment{committee}{%
\DTLnewdb{committee}
}%
{%
\DTLsort{last}{committee}
}





%%% additional titlepage content commands

\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}\setboolean{@subtitle}{true}}

  

%%% abstract
\newenvironment{abstract}[1][Abstract]{%
\chapter*{#1\markboth{#1}{}}
}


\renewcommand\listfigurename{Figures}
\renewcommand\listtablename{Tables}


\renewcommand\tableofcontents{%
\ifthenelse{\boolean{@hypermode}}{\phantomsection}{}
\addcontentsline{toc}{chapter}{\contentsname}%
    \chapter*{\contentsname
        \@mkboth{\contentsname}{\contentsname}}%
    \@starttoc{toc}%
\cleardoublepage
    }

\renewcommand\listoffigures{%
\ifthenelse{\boolean{@hypermode}}{\phantomsection}{}
\addcontentsline{toc}{chapter}{List of \listfigurename}%
    \chapter*{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
    \@starttoc{lof}%
\cleardoublepage
    }

\renewcommand\listoftables{%
\ifthenelse{\boolean{@hypermode}}{\phantomsection}{}
\addcontentsline{toc}{chapter}{List of \listtablename}%
    \chapter*{\listtablename}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \@starttoc{lot}%
    }

\renewenvironment{theindex}
               {\twocolumn[\@makeschapterhead{\indexname}]%
                \ifthenelse{\boolean{@hypermode}}{\phantomsection}{}
		\addcontentsline{toc}{chapter}{\indexname}
                \@mkboth{\indexname}%
                        {\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {}


%%% other useful packages

\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{textcomp}
\RequirePackage{url}
\RequirePackage{amsmath}
\RequirePackage[square]{natbib}
\bibliographystyle{ieeetr}

%%% lowercase header for bibliography and corresponding entry in the
%%% ToC. \bibsection is provided by the natbib package
\renewcommand\bibsection{
\chapter*{\bibname \@mkboth{\bibname}{\bibname}}
\ifthenelse{\boolean{@hypermode}}{\phantomsection}{}
\addcontentsline{toc}{chapter}{\bibname}
}

%%% switch on hyperref support
\ifthenelse{\boolean{@hypermode}}{%
\RequirePackage[unicode,plainpages=false,pdfpagelabels,breaklinks]{hyperref}
\RequirePackage[all]{hypcap}
}{}

%%% other formatting stuff

\renewcommand{\baselinestretch}{1.05}


