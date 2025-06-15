%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** Version Information ********************************
%%
%% Copyright (C) Huangrui Mo <huangrui.mo@gmail.com> 
%% This is free software: you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ucasthesis}
  [2014/10/01 v1.0 ucasthesis
   document class]
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** Declare Options **************************************
%%
%% end-user parameters, each option is declared by one declare option command
\newif\ifUCAS@versioninfo \UCAS@versioninfofalse
\DeclareOption{draftversion}{% draft information reminder
  \UCAS@versioninfotrue%
}
\newif\ifUCAS@singlesided \UCAS@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
  \UCAS@singlesidedtrue%
}
\newif\ifUCAS@doublesided \UCAS@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
  \UCAS@doublesidedtrue%
}
\newif\ifUCAS@printcopy \UCAS@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
  \UCAS@doublesidedtrue% auto enable double-sided style
  \UCAS@printcopytrue%
}
\DeclareOption*{% handle non-implemented options
  \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%% terminates all options processing
\ProcessOptions\relax
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** Loadclass Infomation *********************************
%%
\ifUCAS@doublesided% if double-sided printing enabled
  \LoadClass[UTF8,a4paper,twoside,fntef,12pt]{ctexbook}
\else% if double-sided printing isn't enabled
  \LoadClass[UTF8,a4paper,oneside,fntef,12pt]{ctexbook}
\fi
%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** Package Infomation *********************************
%%
%% color packages
\RequirePackage[usenames,dvipsnames,table]{xcolor}%
%% math packages
\RequirePackage{amsmath,amssymb,amstext}
%%%%% --------------------------------------------------------------------------------
%%
%%%%************************ Load Class Configuretion ********************************
%%
\AtEndOfPackage{%class cfg loaded after package, makes commands at preamble take effect
  \makeatletter
  \InputIfFileExists{Style/ucasthesis.cfg}{}{}
  \makeatother
}
%%%%% --------------------------------------------------------------------------------
%%
%%%%******************************* Page Layout **************************************
%%
%% part one -- horizontal widths 第一部分——水平宽度
%% left side width + textwidth + right side width = paperwidth左侧宽度+文本宽度+右侧宽度=纸张宽度
%% left side width of [odd, even] page = [odd, even]sidemargin + 1.0in (fixed) + hoffset [奇数，偶数]页的左侧宽度=[奇数，奇数]侧边距+1.0英寸（固定）+hoffset
%% binding side width + textwidth + nonbinding side width = paperwidth 装订页宽度+文本宽度+非装订页宽度=纸张宽度
%% binding side width of [odd, even] page = [left, right] side width [奇数，偶数]页的装订边宽度=[左，右]边宽度
%% assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{150mm}% set required text width first
\ifUCAS@printcopy% if print copy layout enabled
  \setlength{\oddsidemargin}{30mm}% binding side width
  \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
  \setlength{\oddsidemargin}{5mm}% left side width
  \setlength{\evensidemargin}{5mm}% ensure uniform left side width for EThesis
\fi
 %% set margin for notes to zero
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%% part two -- vertical heights
%% top height + textheight + bottom height = paperheight
%% top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{240mm}% set required text height first
\setlength{\voffset}{-15mm}% set a minimum header height
\setlength{\headheight}{15pt}% set a minimum header height
%% specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%% line spacing
\renewcommand{\baselinestretch}{1.4} % line space setting
\raggedbottom % prevent adding vertical white space in strange places
%% default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************* Some Style Control Commands ********************************
%%
%% redefine cleardoublepage to empty pages清除双页重新定义为空页
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \thispagestyle{empty}%不显示页眉
\hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
%% underline
\renewcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}
\def\UCAS@underline[#1]#2{%
    \CJKunderline{\hbox to #1{\hfill#2\hfill}}}
\def\UCASunderline{\@ifnextchar[\UCAS@underline\CJKunderline}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************** Chinese Titlepage Items ***********************************
%%
\newcommand\Classificationnumber[1]{\def\UCAS@value@Classificationnumber{#1}}
\newcommand\confidential[1]{\def\UCAS@value@confidential{#1}}
\newcommand\UDC[1]{\def\UCAS@value@UDC{#1}}
\newcommand\Studentnumber[1]{\def\UCAS@value@Studentnumber{#1}}
\newcommand\schoollogo[2]{\def\UCAS@value@schoollogo{\includegraphics[#1]{#2}}}
\newcommand\xueweilogo[2]{\def\UCAS@value@xueweilogo{\includegraphics[#1]{#2}}}

%\renewcommand\title[2][\UCAS@value@title]{%
  %\def\UCAS@label@title{#2}
  %\def\UCAS@value@titlemark{\MakeUppercase{#1}}}本来就注释好的
  %\def\UCAS@value@titlemark{#1}}
%\def\@title{\UCAS@value@titlemark}
\renewcommand\title[2][\UCAS@value@title]{%
  \def\UCAS@value@title{#2}
  %\def\UCAS@value@titlemark{\MakeUppercase{#1}}}
  \def\UCAS@value@titlemark{#1}}
\def\@title{\UCAS@value@titlemark}
\renewcommand\author[1]{\def\UCAS@value@author{#1}}
\newcommand\advisor[1]{\def\UCAS@value@advisor{#1}}
\newcommand\advisorinstitute[1]{\def\UCAS@value@advisorinstitute{#1}}
\newcommand\degree[1]{\def\UCAS@value@degree{#1}}
\newcommand\degreetype[1]{\def\UCAS@value@degreetype{#1}}
\newcommand\subject[1]{\def\UCAS@value@subject{#1}}
\newcommand\major[1]{\def\UCAS@value@major{#1}}
\newcommand\institute[1]{\def\UCAS@value@institute{#1}}
\newcommand\chinesedate[1]{\def\UCAS@value@chinesedate{#1}}
\newcommand\site[1]{\def\UCAS@value@site{#1}}

%%%%% --------------------------------------------------------------------------------
%%
%%%%**************************** Make Chinese Titlepage ******************************
%%
\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \zihao{5}\songti
    \noindent{} {\UCAS@label@Classificationnumber {\zihao{5}\songti\UCAS@value@Classificationnumber}}
    \hfill{} {\UCAS@label@confidential {\zihao{5}\songti\UCAS@value@confidential}\hphantom{320320320320asdaasdas~}}
    \\
    \noindent{} {\UCAS@label@UDC {\zihao{5}\songti\UCAS@value@UDC}}
    \hfill{} {\UCAS@label@Studentnumber {\zihao{5}\songti\UCAS@value@Studentnumber}\hphantom{320320320}}
    \vskip \stretch{0.25}
      \UCAS@value@schoollogo
    \vskip \stretch{0.2}
      \UCAS@value@xueweilogo
      %{\zihao{1} \yahei { \textcolor[RGB]{24,67,121}{\scalebox{1.5}[1.1]{硕~士~学~位~论~文}}}}%字体缩放长1.1倍宽1.5。 颜色调好 对了把这里的硕士换成博士
      %{\zihao{1}\heiti \UCAS@value@degree\UCAS@label@thesis} %原先代码,已注释空
    \vskip \stretch{0.15}
    {\zihao{2}\heiti \textbf {\ \UCAS@value@title \)}}  
    % {\zihao{3} \UCASunderline{\ \UCAS@value@title\ }}验证题目出问题,已经验证成功
    \vskip \stretch{0.25}
    \def\tabcolsep{1pt}
    \def\arraystretch{1.4} %阵列拉伸比例
    {\zihao{3}\heiti \textbf {\UCAS@value@author}}
    \vskip \stretch{0.1}
    %\hskip -15pt
    \begin{tabular}{cl}
     {\zihao{4} \UCAS@label@advisor & \UCASunderline[120pt]{\leftline{\zihao{4} \UCAS@value@advisor}}}
    \\
     {\zihao{4} \songti \UCAS@label@degree & \UCASunderline[120pt]{\leftline{\zihao{4}{\UCAS@value@degreetype\UCAS@value@degree}}}}
    \\
     {\zihao{4} \songti \UCAS@label@subject & \UCASunderline[120pt]{\leftline{\zihao{4}\UCAS@value@subject}}}
    \\
     {\zihao{4} \songti\UCAS@label@major & \UCASunderline[120pt]{\leftline{\zihao{4}\UCAS@value@major}}}
    \\
     {\zihao{4} \songti\UCAS@label@institute & \UCASunderline[120pt]{\leftline{\zihao{4}\UCAS@value@institute}}}
     \\ 
    \end{tabular}
    \vskip \stretch{0.3}
    {\zihao{3}\heiti \UCAS@value@site}
    \vskip \stretch{0.05}
    {\zihao{3} \songti \UCAS@value@chinesedate}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \ifUCAS@versioninfo
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Draft Version (\today)
      \end{footnotesize}
    \fi
    \cleardoublepage
  \else
    \ifUCAS@versioninfo
      \thispagestyle{empty}
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Draft Version (\today)
      \end{footnotesize}
      \cleardoublepage
    \fi
  \fi
}
%%%%% --------------------------------------------------------------------------------
%%%%*********************** English Titlepage Items **********************************
%%
\newcommand\englishtitle[1]{\def\UCAS@value@englishtitle{#1}}
\newcommand\englishauthor[1]{\def\UCAS@value@englishauthor{#1}}
\newcommand\englishadvisor[1]{\def\UCAS@value@englishadvisor{#1}}
\newcommand\englishdegree[1]{\def\UCAS@value@englishdegree{#1}}
\newcommand\englishthesistype[1]{\def\UCAS@value@englishthesistype{#1}}
\newcommand\englishmajor[1]{\def\UCAS@value@englishmajor{#1}}
\newcommand\englishinstitute[1]{\def\UCAS@value@englishinstitute{#1}}
\newcommand\englishdate[1]{\def\UCAS@value@englishdate{#1}}
\newcommand\Committeerlogo[2]{\def\UCAS@value@Committeerlogo{\includegraphics[#1]{#2}}}
%%%%% --------------------------------------------------------------------------------
%%
%%%%**************************** Make Blind review Titlepage ******************************
%%
\newcommand\makeblind{%盲审版
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \hphantom{320320320}
    \vskip \stretch{0.05}
      \UCAS@value@schoollogo
    \vskip \stretch{0.075}
      \UCAS@value@xueweilogo
      %{\zihao{1} \yahei { \textcolor[RGB]{24,67,121}{\scalebox{1.5}[1.1]{硕~士~学~位~论~文}}}}%字体缩放长1.1倍宽1.5。 颜色调好 对了把这里的硕士换成博士
      %{\zihao{1}\heiti \UCAS@value@degree\UCAS@label@thesis} %原先代码,已注释空
    \vskip \stretch{0.1}
    {\zihao{2}\heiti \textbf {\ \UCAS@value@title \)}}  
    % {\zihao{3} \UCASunderline{\ \UCAS@value@title\ }}验证题目出问题,已经验证成功
    \vskip \stretch{0.25}
    \def\tabcolsep{1pt}
    \def\arraystretch{1.4} %阵列拉伸比例
    \vskip \stretch{0.1}
    %\hskip -15pt
    \begin{tabular}{cl}
     {\zihao{4} \songti \UCAS@label@degree & \UCASunderline[120pt]{\leftline{\zihao{4}{\UCAS@value@degreetype\UCAS@value@degree}}}}
    \\
     {\zihao{4} \songti \UCAS@label@subject & \UCASunderline[120pt]{\leftline{\zihao{4}\UCAS@value@subject}}}
    \\
     {\zihao{4} \songti\UCAS@label@major & \UCASunderline[120pt]{\leftline{\zihao{4}\UCAS@value@major}}}
    \\
    \end{tabular}
    \vskip \stretch{0.3}
    {\zihao{3}\heiti \UCAS@value@site}
    \vskip \stretch{0.025}
    {\zihao{3} \songti \UCAS@value@chinesedate}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \ifUCAS@versioninfo
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Draft Version (\today)
      \end{footnotesize}
    \fi
    \cleardoublepage
  \else
    \ifUCAS@versioninfo
      \thispagestyle{empty}
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Draft Version (\today)
      \end{footnotesize}
      \cleardoublepage
    \fi
  \fi
}
%%%%% --------------------------------------------------------------------------------
%%

%%%%*********************** Make  committee  ***********************************
%%
\newcommand\makecommittee{%
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \UCAS@value@Committeerlogo
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}
%%%
%%%%% --------------------------------------------------------------------------------
%%
%%%%*********************** Make Author Declaration ***********************************
%%
\newcommand\makedeclaration{%
  \cleardoublepage
  \thispagestyle{empty}

  \begin{center}
      {\zihao{-2}\textbf \UCAS@value@declare@create}
  \end{center}

  {\zihao{4}\UCAS@value@declare@creativity}\\

  {\zihao{4}\UCAS@value@declare@s \phantom{32032032032032032323pt} \ \ \UCAS@value@declare@d }\\%还没改好，\hphantom{text}内的参数没调整号

  \vskip 40pt

  \begin{center}
      {\zihao{-2} \textbf \UCAS@value@declare@right}
  \end{center}

  {\zihao{4}\UCAS@value@declare@rights}

  {\zihao{4} \UCAS@value@declare@rule}\\

  {\zihao{4} \UCAS@value@declare@s \hphantom{32032032032032032323pt}  \UCAS@value@declare@d}\\%还没改好，\hphantom{text}内的参数没调整号
  {\hphantom{~3203}\zihao{4} \UCAS@value@declare@t \hphantom{32032032032032032323pt} \UCAS@value@declare@d}%还没改好，\hphantom{text}内的参数没调整号

  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}
%%%%% --------------------------------------------------------------------------------
%%
%%%%****************************** New Environments **********************************
%%
%% define chinese abstract
\newenvironment{abstract}
{\chapter[\UCAS@label@abstract]{
     {\zihao{-2}\heiti \textmd{\UCAS@value@title}}
     \vskip 10pt
     {\zihao{-3}\heiti \textmd{\UCAS@label@abstract}}
  }}
  {}
%% define chinese keywords
\newcommand\keywords[1]{%
    \vspace{2ex}\noindent{\zihao{-4}\heiti \UCAS@label@keywords} #1}
%% define engish abstract
\newenvironment{englishabstract}
{\chapter[\UCAS@label@englishabstract]{
     {\zihao{-2} \textbf \UCAS@value@englishtitle}
     \vskip 20pt
     {\zihao{-3} \textbf \UCAS@label@englishabstract}
  }}
  {}
%% define engish keywords
\newcommand\englishkeywords[1]{%
  \vspace{2ex}\noindent{\zihao{-4} \textbf \UCAS@label@englishkeywords} #1}
%%%%% --------------------------------------------------------------------------------
%%
%%%%**************************** Dotted Line in TOC **********************************目录中的虚线
%%
%% define spacing and length 定义间距和长度
\def\@dotsep{0.5mu}% spacing for dots 点的间距
\def\@pnumwidth{1em}% spacing between titles and page numbers 标题和页码之间的间距
\def\@tocrmarg{2em}% right margin indentation 右边缘缩进
\def\@chaptervspace{1bp}% spacing between chapter titles 章节标题之间的间距
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par\penalty\@highpenalty}%
  \fi}
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large  #1
       \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}
       \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip \@chaptervspace \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode 
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak
      \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}
      \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
%%%%% --------------------------------------------------------------------------------
\endinput
%% End of file
%%%%% --------------------------------------------------------------------------------
