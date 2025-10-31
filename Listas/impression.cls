\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{impression}[2025/04/14 A Impression, soleil levant Template]

\newif\ifhyper\hypertrue
\DeclareOption{nohyper}{\hyperfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax
\LoadClass{memoir}
\PassOptionsToPackage{colorlinks  = true, 
                urlcolor        = orange, 
                anchorcolor     = orange, 
                citecolor       = orange, 
                filecolor       = orange, 
                linkcolor       = orange, 
                menucolor       = orange, 
                linktocpage     = true, 
                bookmarks       = true,
                pdfusetitle}{hyperref}
\RequirePackage{mypackages}

\definecolor{MyWhite}{HTML}{ffffff} % Page color
\definecolor{MyBlack}{HTML}{101010} % Black
\definecolor{MyGray}{HTML}{797b6e} % Gray 
\definecolor{MyLightGray}{HTML}{ececd4} % Light Gray
\definecolor{MyLightBlue}{HTML}{5e8276} % Light Blue
\definecolor{MyDarkBlue}{HTML}{013533} % Dark Blue
\definecolor{MyOrange}{HTML}{df5934} % Orange



\def\@hwnumber{\@empty}
\providecommand{\hwnumber}[1]{\gdef\@hwnumber{\two@digits{#1}}}
\renewcommand{\hwnumber}[1]{\gdef\@hwnumber{\two@digits{#1}}}

\def\@subtitle{\@empty}
\providecommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\renewcommand{\subtitle}[1]{\gdef\@subtitle{#1}}

\def\@extra{\@empty}
\providecommand{\extra}[1]{\gdef\@extra{#1}}
\renewcommand{\extra}[1]{\gdef\@extra{#1}}

\setlength{\fboxsep}{-1pt}%
\setlength{\fboxrule}{1pt}

\renewcommand{\maketitle}{%
    \thispagestyle{empty}
    \pagenumbering{arabic}
    \pagecolor{MyWhite}
    \newgeometry{left=4cm, right=0cm, top=0cm, bottom=2cm}
    \thiswatermark{ }
    \renewcommand{\today}{
        \hspace{-5em}\ifnum\number\day<10 0\fi \number\day
        
        \hspace{-5em}\ifnum \number\month<10 0\fi \number\month
    } 
    
        {\hfill\color{MyLightGray}\fontsize{380}{380}\selectfont\@hwnumber}
        \vspace{2ex}
        
        {\parbox{35em}{\fontsize{30}{30}\selectfont\bfseries\thetitle\phantom{Ç}}}

        {\parbox{35em}{\huge\@subtitle}}
        \vspace{4em}

        {\parbox{35em}{\Large\@author}}
        \vspace{1ex}

        {\parbox{35em}{\Large\@extra}}
        \vspace{2em}

        \includegraphics[width=35em]{Figures/Impression, soleil levant - Claude Monet.png}
        \vspace{-26em}
        
        \hspace{2em}\fbox{\transparent{0}\includegraphics[width=35em]{Figures/Impression, soleil levant - Claude Monet.png}}
        \vspace{-2em}
        
        {\bfseries\Large\today} \afterpage{\nopagecolor}
    \restoregeometry
    \clearpage
    \setcounter{page}{1}
   
}

\watermark{
    \put(-1140,-763.5){\includegraphics[height=\paperheight]{Figures/Impression, soleil levant - Claude Monet.png}}
    \put(400,-10){\transparent{0.1}\includegraphics[height=2.5cm]{Figures/vanilla.png}}
}

\makechapterstyle{mychapsty}{%
    \renewcommand*{\printchaptername}{\@empty}
    \renewcommand*{\printchapternum}{%
        \chapnumfont%
        {\fontsize{45}{45}\selectfont Q. \two@digits{\thechapter}}%
    }
    \renewcommand*{\chapnumfont}{\normalfont}
    \renewcommand*{\chaptitlefont}{\normalfont}
    \renewcommand*{\printchaptertitle}[1]{%
        \vspace{-2.72em} \par\hspace{0.25\linewidth}\rule{0.75\linewidth}{1pt}\par \vspace{1em}
        \vspace{-2.72em} \par\hspace{0.25\linewidth}\chaptitlefont {\color{MyGray}##1} \par \vspace{0.5ex}%
    }
    \renewcommand*{\afterchaptertitle}{%
        \vskip \afterchapskip \vspace{-2em}%
    }
    \setlength{\beforechapskip}{3\baselineskip}
    \gdef\clearforchapter{}
}
\chapterstyle{mychapsty}

\newenvironment{exercise}[1]{
    \noindent\color{MyGray}#1
}{\color{MyBlack}\par\noindent\rule{\linewidth}{1pt}\medskip}


\pagestyle{plain}

\newcommand{\makefinal}{%
    \clearpage
    \printbibliography[heading=none]
    % \nocite{Peskin,Schwartz}
}

\newtcolorbox{answer}[1][]{
    ams align,
    colback = MyLightGray,
    colframe = MyLightGray,
    arc = 0mm,
    outer arc = 0mm,
    boxrule = 0mm,
    #1
}

\newcommand{\normord}[1]{\mkern4mu:\mathrel{#1}:\mkern4mu}

\renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
  \hskip -\arraycolsep
  \let\@ifnextchar\new@ifnextchar
  \array{#1}}
\makeatother

\newcommand*{\boldone}{\mathds{1}}



\newcommand*\eqlineset{\pgfqkeys{/eqlines}}

\eqlineset{
  picture/.style={baseline, remember picture},
  line/.style={thick, draw=MyOrange, line cap=round},
  node/.style={
    minimum size=+0pt, inner sep=+0pt, outer ysep=+.3333em, anchor=base,
    name=tma\thetikzmarkalign},
}

\newcounter{tikzmarkalign}

\makeatletter
\AtBeginEnvironment{align}{%
  \setcounter{tikzmarkalign}{0}%
  \newcommand*\noeq{\hphantom{={}}}%
  \newcommand*\eq{
    \ifnum\value{tikzmarkalign}=0
      \mathrel{\tikz[/eqlines/picture]\node[/eqlines/node]{$=$};}
    \else
      \mathrel{
        \begin{tikzpicture}[/eqlines/picture]
          \node[/eqlines/node] (tma\thetikzmarkalign) {$=$};
          \unless\ifmeasuring@
            \path[/eqlines/line, overlay] (tma\thetikzmarkalign)
                        -- (tma\pgfinteval{\thetikzmarkalign-1});
          \fi
        \end{tikzpicture}
      }
    \fi
    \stepcounter{tikzmarkalign}
  }%
}
\makeatother
\makeatletter
\AtBeginEnvironment{align*}{%
  \setcounter{tikzmarkalign}{0}%
  \newcommand*\noeq{\hphantom{={}}}%
  \newcommand*\eq{
    \ifnum\value{tikzmarkalign}=0
      \mathrel{\tikz[/eqlines/picture]\node[/eqlines/node]{$=$};}
    \else
      \mathrel{
        \begin{tikzpicture}[/eqlines/picture]
          \node[/eqlines/node] (tma\thetikzmarkalign) {$=$};
          \unless\ifmeasuring@
            \path[/eqlines/line, overlay] (tma\thetikzmarkalign)
                        -- (tma\pgfinteval{\thetikzmarkalign-1});
          \fi
        \end{tikzpicture}
      }
    \fi
    \stepcounter{tikzmarkalign}
  }%
}
\makeatother

\def\endex{
  \begin{center}
    \pgfornament[width=3cm, opacity=0.1]{80}
  \end{center}
}