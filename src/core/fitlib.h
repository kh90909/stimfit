// Header file for the stimfit namespace
// Routines for fitting functions to data
// last revision: 08-08-2006
// C. Schmidt-Hieber, christsc@gmx.de

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

/*! \file fitlib.h
 *  \author Christoph Schmidt-Hieber
 *  \date 2008-01-16
 *  \brief Functions for linear and non-linear regression.
 */

#ifndef _FITLIB_H
#define _FITLIB_H

#include "./stimdefs.h"
#include <deque>

namespace stf {

/*! \addtogroup stfgen
 *  @{
 */

//! Performs a linear fit.
/*! \param x The x- values of the data that are to be fitted.
 *  \param y The y- values of the data that are to be fitted.
 *  \param m On exit, the slope of the regression line.
 *  \param c On exit, the y-intercept of the regression line.
 *  \return A valarray containing the waveform of the fitted function.
 */
template <typename T>
T linFit(
        const std::valarray<T>& x,
        const std::valarray<T>& y,
        T& m,
        T& c
);

//! Uses the Levenberg-Marquardt algorithm to perform a non-linear least-squares fit.
/*! \param data A valarray containing the data.
 *  \param dt The sampling interval of \e data.
 *  \param fitFunc An stf::storedFunc to be fitted to \e data.
 *  \param opts Options controlling Lourakis' implementation of the algorithm.
 *  \param p \e func's parameters. Should be set to an initial guess 
 *         on entry. Will contain the best-fit values on exit.
 *  \param info Information about why the fit stopped iterating
 *  \param warning A warning code on return.
 *  \return The sum of squred errors between \e data and the best-fit function.
 */
double StfDll lmFit(const std::valarray<double>& data, double dt,
        const stf::storedFunc& fitFunc, const std::valarray<double>& opts,
        std::valarray<double>& p, wxString& info, int& warning );

//! Linear function.
/*! \f[f(x)=p_0 x + p_1\f]
 *  \param x Function argument.
 *  \param p A valarray of parameters, where \n
 *         \e p[0] is the slope and \n
 *         \e p[1] is the y intersection.
 *  \return The evaluated function.
 */
double flin(double x, const std::valarray<double>& p);

//! Dummy function to be passed to stf::storedFunc for linear functions.
void flin_init(const std::valarray<double>& data, double base, double peak,
        double dt, std::valarray<double>& pInit );

stf::storedFunc initLinFunc();

}

template <typename T>
T stf::linFit(const std::valarray<T>& x,
        const std::valarray<T>& y,
        T& m,
        T& c)
{
    double sum_x=0.0;
    double sum_y=0.0;
    double sum_xx=0.0;
    double sum_xy=0.0;
    for (unsigned n=0;n<x.size();++n) {
        sum_x+=x[n];
        sum_y+=y[n];
        sum_xx+=x[n]*x[n];
        sum_xy+=x[n]*y[n];
    }
    m=(T)(((T)x.size()*sum_xy-sum_x*sum_y)/((T)x.size()*sum_xx-sum_x*sum_x));
    c=(T)((sum_y-m*sum_x)/(T)x.size());
    T error = 0.0;
    for (unsigned n=0;n<x.size();++n) {
        error += (y[n]-(m*x[n]+c)) * (y[n]-(m*x[n]+c));
    }
    return error;

    /*@}*/

}

#endif