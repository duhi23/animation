

##' Demonstration of the Bisection Method for Root-finding on an Interval
##' A visual demonstration of finding the root of an equation \eqn{f(x) = 0} on
##' an interval using the Bisection Method.
##' 
##' Suppose we want to solve the equation \eqn{f(x) = 0}. Given two points a
##' and b such that \eqn{f(a)} and \eqn{f(b)} have opposite signs, we know by
##' the intermediate value theorem that \eqn{f} must have at least one root in
##' the interval \eqn{[a, b]} as long as \eqn{f} is continuous on this
##' interval. The bisection method divides the interval in two by computing
##' \eqn{c = (a + b) / 2}. There are now two possibilities: either \eqn{f(a)}
##' and \eqn{f(c)} have opposite signs, or \eqn{f(c)} and \eqn{f(b)} have
##' opposite signs. The bisection algorithm is then applied recursively to the
##' sub-interval where the sign change occurs.
##' 
##' During the process of searching, the mid-point of subintervals are
##' annotated in the graph by both texts and blue straight lines, and the
##' end-points are denoted in dashed red lines. The root of each iteration is
##' also plotted in the right margin of the graph.
##' 
##' @param FUN the function in the equation to solve (univariate)
##' @param rg a vector containing the end-points of the interval to be searched
##'   for the root; in a \code{c(a, b)} form
##' @param tol the desired accuracy (convergence tolerance)
##' @param interact logical; whether choose the end-points by cliking on the
##'   curve (for two times) directly?
##' @param xlab,ylab,main axis and main titles to be used in the plot
##' @param \dots other arguments passed to \code{\link[graphics]{curve}}
##' @return A list containing \item{root }{the root found by the algorithm}
##'   \item{value }{the value of \code{FUN(root)}} \item{iter}{number of
##'   iterations; if it is equal to \code{ani.options('nmax')}, it's quite
##'   likely that the root is not reliable because the maximum number of
##'   iterations has been reached}
##' @author Yihui Xie <\url{http://yihui.name}>
##' @seealso \code{\link[stats]{deriv}}, \code{\link[stats]{uniroot}}
##' @references \url{http://en.wikipedia.org/wiki/Bisection_method}
##' 
##' \url{http://animation.yihui.name/compstat:bisection_method}
##' @keywords optimize dynamic dplot
##' @examples
##' 
##' # default example 
##' xx = bisection.method() 
##' xx$root  # solution
##' 
##' # a cubic curve 
##' f = function(x) x^3 - 7 * x - 10 
##' xx = bisection.method(f, c(-3, 5)) 
##' 
##' \dontrun{
##' # interaction: use your mouse to select the end-points 
##' bisection.method(f, c(-3, 5), interact = TRUE) 
##' 
##' # HTML animation pages 
##' ani.start(nmax = 50, ani.height = 400, ani.width = 600, interval = 1,
##'     title = "The Bisection Method for Root-finding on an Interval",
##'     description = "The bisection method is a root-finding algorithm
##'     which works by repeatedly dividing an interval in half and then
##'     selecting the subinterval in which a root exists.")
##' par(mar = c(4, 4, 1, 2))
##' bisection.method(main = "")
##' ani.stop() 
##' }
##' 
`bisection.method` <- function(FUN = function(x) x^2 -
    4, rg = c(-1, 10), tol = 0.001, interact = FALSE, main, xlab,
    ylab, ...) {
    if (interact) {
        curve(FUN, min(rg), max(rg), xlab = "x", ylab = eval(substitute(expression(f(x) ==
            y), list(y = body(FUN)))), main = "Locate the interval for finding root")
        rg = unlist(locator(2))[1:2]
    }
    l = min(rg)
    u = max(rg)
    if (FUN(l) * FUN(u) > 0)
        stop("The function must have opposite signs at the lower and upper boundof the range!")
    mid = FUN((l + u)/2)
    i = 1
    bd = rg
    if (missing(xlab))
        xlab = names(formals(FUN))
    if (missing(ylab))
        ylab = eval(substitute(expression(f(x) == y), list(y = body(FUN))))
    if (missing(main))
        main = eval(substitute(expression("Root-finding by Bisection Method:" ~
            y == 0), list(y = body(FUN))))
    interval = ani.options("interval")
    while (abs(mid) > tol & i <= ani.options("nmax")) {
        curve(FUN, min(rg), max(rg), xlab = xlab, ylab = ylab,
            main = main, ...)
        abline(h = 0, col = "gray")
        abline(v = bd, col = "red", lty = 2)
        abline(v = (l + u)/2, col = "blue")
        arrh = mean(par("usr")[3:4])
        if (u - l > 0.001 * diff(par("usr")[1:2])/par("din")[1])
            arrows(l, arrh, u, arrh, code = 3, col = "gray",
                length = par("din")[1]/2^(i + 2))
        mtext(paste("Current root:", (l + u)/2), 4)
        bd = c(bd, (l + u)/2)
        assign(ifelse(mid * FUN(l) > 0, "l", "u"), (l + u)/2)
        mid = FUN((l + u)/2)
        Sys.sleep(interval)
        i = i + 1
    }
    ani.options(nmax = i - 1)
    invisible(list(root = (l + u)/2, value = mid, iter = i -
        1))
}