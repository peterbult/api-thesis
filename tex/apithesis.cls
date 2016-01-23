% |---------------------------------------------------------------------
% 
%   apithesis.cls:  The API LaTeX thesis template
% 
% |---------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1995/12/01]% 
\ProvidesClass{apithesis}[2015/10/01]

% |---------------------------------------------------------------------

% Declare an ifdraft variable to allow for draft-conditional
% formatting (for an example see the titlepage)
\newif\ifdraft

% Declare an ifprint variable for digital/print-conditional
% formatting (for an example see the main tex file)
\newif\ifprint

% Declare a number of internal formatting flags
\newif\if@enableFinalMode
\newif\if@enableCropMode
\newif\if@enableFrame       % Control text frame

% |---------------------------------------------------------------------

% Dissect the class options
\DeclareOption{final}{\draftfalse}
\DeclareOption{draft}{\drafttrue}

\DeclareOption{print}{\printtrue}
\DeclareOption{noprint}{\printfalse}

\DeclareOption{cropmarks}{\@enableCropModetrue}
\DeclareOption{nocropmarks}{\@enableCropModefalse}

\DeclareOption{frame}{\@enableFrametrue}
\DeclareOption{noframe}{\@enableFramefalse}

% Pass all unspecified options to the parent class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ExecuteOptions{11pt,noframe,nocropmarks,noprint,draft}
\ProcessOptions\relax

% Process class options
\ifdraft
    \typeout{   Compiling thesis with DRAFT markup}
    \typeout{   > Setting paper size to A4}
    \typeout{   > Setting typeset size to B5}
    \PassOptionsToClass{a4paper,twoside,openright,dvips}{book}
    \PassOptionsToPackage{textwidth=130mm,textheight=190mm}{geometry}
    \PassOptionsToPackage{paperwidth=170mm,paperheight=240mm}{geometry}
    \PassOptionsToPackage{top=13mm,headheight=13pt}{geometry}
    \PassOptionsToPackage{driver=none}{geometry} % disable driver for crop package compatibility   
\else
    \typeout{   Compiling thesis with FINAL markup}
    \typeout{   > Setting paper size to B5}
    \typeout{   > Setting typeset size to B5}
    \typeout{   > Disabling frame/crop markers}
    \PassOptionsToClass{b5paper,twoside,openright,dvips}{book}
    \PassOptionsToPackage{textwidth=130mm,textheight=190mm}{geometry}
    \PassOptionsToPackage{paperwidth=170mm,paperheight=240mm}{geometry}
    \PassOptionsToPackage{top=13mm,headheight=13pt}{geometry}
    \PassOptionsToPackage{driver=dvips}{geometry} % set driver
\fi

% Set the default execution mode
%\ExecuteOptions{11pt,noframe,nocropmarks,draft}

% Execute the option declarations
\ProcessOptions\relax

% Load the parent class
\LoadClass{book}

% |---------------------------------------------------------------------

% Load the page formatting packages
\RequirePackage{geometry}
% Switch basic frame
% Switch crop marks (works only in draft mode)
\ifdraft
    \RequirePackage[cam,a4,center,noinfo,axes,dvips]{crop}
    \if@enableFrame \RequirePackage{showframe} \fi
    \if@enableCropMode \else \crop[off] \fi
\fi

% Load bibliography packages
\RequirePackage{natbib}         
\bibpunct{(}{)}{;}{a}{}{,}  % to follow the A&A style
%\input{journals}            % defines journal shortcuts

% Load hyperref
\RequirePackage[%
    draft=false,
    breaklinks=true,
    citecolor=blue,
    linkcolor=blue,
    pdfstartpage=1,
    pdfpagelayout=TwoColumnRight]{hyperref}

\ifprint
	\hypersetup{colorlinks = false}
\else
	\hypersetup{colorlinks = true}
\fi
   

% Load math formatting packages
\RequirePackage{amsmath}        
\RequirePackage{amssymb}        
\RequirePackage{amsfonts}       

% Add languages support needed for the correct hyphenation in Dutch summary
\RequirePackage[dutch,english]{babel} 
\usepackage[T1]{fontenc}

% Load auxiliary packages
\RequirePackage{lipsum}         % for \lipsum page filler 
\RequirePackage{color}          % for colored text
\RequirePackage{graphicx}       % for cross-references between chapters
\RequirePackage{subfigure}      % for multiple plots in one figure environment
\RequirePackage{verbatim}       % for multiline comments
\RequirePackage{xspace}         % for a clever space command
\RequirePackage{xr}             % for cross-references between chapters, see introduction for example
\RequirePackage{stfloats}       % for \baselineskip command and float formatting, see layout.tex
%\RequirePackage{fancyhdr}		% for header/footer control: moved to layout.tex
%\RequirePackage{sidecap}       % allows for captions to placed aside a figure instead of below
\RequirePackage{nameref}        % allows for referencing a section name, used in coauthors.tex





%\RequirePackage[table]{xcolor}        % alternative for the [color] package
%\RequirePackage{relsize}       % allows for fontsize scaling relative to surrounding text
%\RequirePackage{rotating}      % allows for float environments to be rotated on the page
%\RequirePackage{soul}          % allows underline and strikethrough highlighting
%\RequirePackage{epstopdf}      % package for mactex



% Load various table packages
\RequirePackage{multirow}           % for merging table cells vertically
%\RequirePackage{cdeluxetable}       % modified implemenation of AASTEX's deluxetable
%\RequirePackage{threeparttable}    % adds some controls for table footnote placement
\RequirePackage{booktabs}          % offers various table controls
\RequirePackage{tabularx}          % offers various table controls
\RequirePackage{longtable}         % offers various table controls
\RequirePackage{rotating}
\RequirePackage{threeparttablex}
%\RequirePackage{ltablex}           % offers various table controls

% Define custom table commands
\newcolumntype{Y}{>{\centering\arraybackslash}X}    % For a center aligned dynamic width column
\newcommand{\nodata}{...}                           % Explicit nodata commands

%
% Miscellaneous commands
\newcommand{\location}[1]{\gdef\@location{#1}}
\newcommand{\birthplace}[1]{\gdef\@birthplace{#1}}



% Redefine the minimum fraction of the page length reserved for text, this
% is needed for proper float placement 
\renewcommand\textfraction{0}	


% In draft mode the graphicx packages does not load figures. This
% commands ensures that figures are loaded at all times.
\setkeys{Gin}{draft=false}


% This ensures that citation hyperlinks are on year only (as opposed to name+year) 
\usepackage{etoolbox}

%\makeatletter

% Patch case where name and year are separated by aysep
\patchcmd{\NAT@citex}
  {\@citea\NAT@hyper@{%
     \NAT@nmfmt{\NAT@nm}%
     \hyper@natlinkbreak{\NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb}%
     \NAT@date}}
  {\@citea\NAT@nmfmt{\NAT@nm}%
   \NAT@aysep\NAT@spacechar\NAT@hyper@{\NAT@date}}{}{}

% Patch case where name and year are separated by opening bracket
\patchcmd{\NAT@citex}
  {\@citea\NAT@hyper@{%
     \NAT@nmfmt{\NAT@nm}%
     \hyper@natlinkbreak{\NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi}%
       {\@citeb\@extra@b@citeb}%
     \NAT@date}}
  {\@citea\NAT@nmfmt{\NAT@nm}%
   \NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi\NAT@hyper@{\NAT@date}}
  {}{}

%\makeatother

% Define bright pink for apj url link
\ifprint
	\definecolor{pink}{RGB}{0,0,0}
    \definecolor{blue}{RGB}{0,0,0}
\else
    \definecolor{pink}{RGB}{255,51,255}
\fi



% Bibliography and bibfile
\def\aj{AJ}%
          % Astronomical Journal
\def\actaa{Acta Astron.}%
          % Acta Astronomica
\def\araa{ARA\&A}%
          % Annual Review of Astron and Astrophys
\def\apj{ApJ}%
          % Astrophysical Journal
\def\apjl{ApJ}%
          % Astrophysical Journal, Letters
\def\apjs{ApJS}%
          % Astrophysical Journal, Supplement
\def\ao{Appl.~Opt.}%
          % Applied Optics
\def\apss{Ap\&SS}%
          % Astrophysics and Space Science
\def\aap{A\&A}%
          % Astronomy and Astrophysics
\def\aapr{A\&A~Rev.}%
          % Astronomy and Astrophysics Reviews
\def\aaps{A\&AS}%
          % Astronomy and Astrophysics, Supplement
\def\azh{AZh}%
          % Astronomicheskii Zhurnal
\def\baas{BAAS}%
          % Bulletin of the AAS
\def\bac{Bull. astr. Inst. Czechosl.}%
          % Bulletin of the Astronomical Institutes of Czechoslovakia 
\def\caa{Chinese Astron. Astrophys.}%
          % Chinese Astronomy and Astrophysics
\def\cjaa{Chinese J. Astron. Astrophys.}%
          % Chinese Journal of Astronomy and Astrophysics
\def\icarus{Icarus}%
          % Icarus
\def\jcap{J. Cosmology Astropart. Phys.}%
          % Journal of Cosmology and Astroparticle Physics
\def\jrasc{JRASC}%
          % Journal of the RAS of Canada
\def\mnras{MNRAS}%
          % Monthly Notices of the RAS
\def\memras{MmRAS}%
          % Memoirs of the RAS
\def\na{New A}%
          % New Astronomy
\def\nar{New A Rev.}%
          % New Astronomy Review
\def\pasa{PASA}%
          % Publications of the Astron. Soc. of Australia
\def\pra{Phys.~Rev.~A}%
          % Physical Review A: General Physics
\def\prb{Phys.~Rev.~B}%
          % Physical Review B: Solid State
\def\prc{Phys.~Rev.~C}%
          % Physical Review C
\def\prd{Phys.~Rev.~D}%
          % Physical Review D
\def\pre{Phys.~Rev.~E}%
          % Physical Review E
\def\prl{Phys.~Rev.~Lett.}%
          % Physical Review Letters
\def\pasp{PASP}%
          % Publications of the ASP
\def\pasj{PASJ}%
          % Publications of the ASJ
\def\qjras{QJRAS}%
          % Quarterly Journal of the RAS
\def\rmxaa{Rev. Mexicana Astron. Astrofis.}%
          % Revista Mexicana de Astronomia y Astrofisica
\def\skytel{S\&T}%
          % Sky and Telescope
\def\solphys{Sol.~Phys.}%
          % Solar Physics
\def\sovast{Soviet~Ast.}%
          % Soviet Astronomy
\def\ssr{Space~Sci.~Rev.}%
          % Space Science Reviews
\def\zap{ZAp}%
          % Zeitschrift fuer Astrophysik
\def\nat{Nature}%
          % Nature
\def\iaucirc{IAU~Circ.}%
          % IAU Cirulars
\def\aplett{Astrophys.~Lett.}%
          % Astrophysics Letters
\def\apspr{Astrophys.~Space~Phys.~Res.}%
          % Astrophysics Space Physics Research
\def\bain{Bull.~Astron.~Inst.~Netherlands}%
          % Bulletin Astronomical Institute of the Netherlands
\def\fcp{Fund.~Cosmic~Phys.}%
          % Fundamental Cosmic Physics
\def\gca{Geochim.~Cosmochim.~Acta}%
          % Geochimica Cosmochimica Acta
\def\grl{Geophys.~Res.~Lett.}%
          % Geophysics Research Letters
\def\jcp{J.~Chem.~Phys.}%
          % Journal of Chemical Physics
\def\jgr{J.~Geophys.~Res.}%
          % Journal of Geophysics Research
\def\jqsrt{J.~Quant.~Spec.~Radiat.~Transf.}%
          % Journal of Quantitiative Spectroscopy and Radiative Trasfer
\def\memsai{Mem.~Soc.~Astron.~Italiana}%
          % Mem. Societa Astronomica Italiana
\def\nphysa{Nucl.~Phys.~A}%
          % Nuclear Physics A
\def\physrep{Phys.~Rep.}%
          % Physics Reports
\def\physscr{Phys.~Scr}%
          % Physica Scripta
\def\planss{Planet.~Space~Sci.}%
          % Planetary Space Science
\def\procspie{Proc.~SPIE}%
          % Proceedings of the SPIE
\let\astap=\aap
\let\apjlett=\apjl
\let\apjsupp=\apjs
\let\applopt=\ao


\endinput 

