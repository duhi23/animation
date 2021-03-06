\name{saveHTML2}
\alias{saveHTML2}
\title{Insert animations into an HTML page}
\usage{
saveHTML2(expr, img.name = "Rplot", title = "Animation Playr", htmlfile = "index.html", 
    pause = 1000, endPause = 2000, loopmode = c("One-shot", "Loop", "Loop-pause"), 
    overwrite = FALSE, description, ...)
}
\arguments{
\item{expr}{an R expression to be evaluated to create a sequence of images}

\item{img.name}{the filename of the images (the real output will be like
  \file{img.name1.png}, \file{img.name2.png}, ...); this name has to be
  different for different animations, since it will be used as the
  identifiers for each animation; make it as unique as possible; meanwhile,
  the following characters in \code{img.name} will be replaced by \code{_} to
  make it a legal jQuery string:

  \verb{!"#$\%&'()*+,./:;?@[\]^`{|}~}}

\item{htmlfile}{the filename of the HTML file}

\item{...}{other arguments to be passed to \code{\link{ani.options}} to
animation options such as the time interval between image frames}

\item{global.opts}{a string: the global options of the animation; e.g. we can
specify the default theme to be blue using
\verb{$.fn.scianimator.defaults.theme = 'blue';} note these options must be
legal JavaScript expressions (ended by \code{';'})}

\item{single.opts}{the options for each single animation (if there are
  multiple ones in one HTML page), e.g. to use the dark theme and text labels
  for buttons:

  \verb{'utf8': false, 'theme': 'dark'}

  or to remove the navigator panel (the navigator can affect the smoothness
  of the animation when the playing speed is extremely fast (e.g.
  \code{interval} less than 0.05 seconds)):

  \verb{'controls': ['first', 'previous', 'play', 'next', 'last', 'loop',
  'speed']}

  see the reference for a complete list of available options}
}
\value{
The path of the HTML output.
}
\description{
This function first records all the plots in the R expression as bitmap
images, then inserts them into an HTML page and finally creates the animation
using a template that uses ANgularJS
}
\details{
Optionally the source code and some session information can be added below
the animations for the sake of reproducibility (specified by the option
\code{ani.options('verbose')} -- if \code{TRUE}, the description, loaded
packages, the code to produce the animation, as well as a part of
\code{\link{sessionInfo}()} will be written in the bottom of the animation;
the R code will be highlighted using the SyntaxHighlighter library for better
reading experience).
}
\note{
Microsoft IE might restrict the HTML page from running JavaScript and
  try to ``protect your security'' when you view the animation page, but this
  is not really a security problem.

  When you want to publish the HTML page on the web, you have  to upload the
  associated \file{css} and \file{js} folders with the HTML file as well as
  the images.

  For \code{\link{saveHTML}}, \code{ani.options('description')} can be a
  character vector, in which case this vector will be pasted into a scalar;
  use \code{'\n\n'} in the string to separate paragraphs (see the first
  example below).

  For the users who do not have R at hand, there is a demo in
  \code{system.file('misc', 'Rweb', 'demo.html', package = 'animation')} to
  show how to create animations online without R being installed locally. It
  depends, however, on whether the Rweb service can be provided for public
  use in a long period (currently we are using the Rweb at Tama University).
  See the last example below.
}
\author{
Yihui Xie, Barry Rowlingson
}
\seealso{
Other utilities: \code{\link{gm.convert}},
  \code{\link{im.convert}}; \code{\link{saveGIF}},
  \code{\link{saveMovie}}; \code{\link{saveHTML}};
  \code{\link{saveLatex}}; \code{\link{saveSWF}};
  \code{\link{saveVideo}}
}
