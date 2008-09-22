%define DOCSTRING
"The stf module allows to access a running stimfit
application from the embedded python shell."
%enddef

%module(docstring=DOCSTRING) stf

%{
#define SWIG_FILE_WITH_INIT
#include "stfswig.h"
%}
%include "numpy.i"
%init %{
import_array();
%}

%define %apply_numpy_typemaps(TYPE)

%apply (TYPE* ARGOUT_ARRAY1, int DIM1) {(TYPE* outvec, int size)};
%apply (TYPE* IN_ARRAY1, int DIM1) {(TYPE* invec, int size)};
%apply (TYPE* IN_ARRAY2, int DIM1, int DIM2) {(TYPE* inarr, int traces, int size)};

%enddef    /* %apply_numpy_typemaps() macro */

%apply_numpy_typemaps(double)

//--------------------------------------------------------------------
%feature("autodoc", 0) _get_trace_fixedsize;
%feature("docstring", "Returns a trace as a 1-dimensional NumPy array.
This returns an array of a given size.
Don't use this, use get_trace instead.
      
Arguments:
size --    Size of the array to be filled.       
trace --   ZERO-BASED index of the trace within the channel.
           Note that this is one less than what is shown
           in the drop-down box.
           The default value of -1 returns the currently
           displayed trace.
channel -- ZERO-BASED index of the channel. This is independent
           of whether a channel is active or not.
           The default value of -1 returns the currently
           active channel.
Returns:
The trace as a 1D NumPy array.") _get_trace_fixedsize;
void _get_trace_fixedsize( double* outvec, int size, int trace, int channel );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) new_window;
%feature("docstring", "Creates a new window showing a
1D NumPy array.
      
Arguments:
invec --   The NumPy array to be shown.") new_window;
void new_window( double* invec, int size );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) _new_window_gVector;
%feature("docstring", "Creates a new window from the global vector.
Do not use directly.") _new_window_gVector;
void _new_window_gVector( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) new_window_matrix;
%feature("docstring", "Creates a new window showing a
2D NumPy array.
      
Arguments:
inarr --   The NumPy array to be shown. First dimension
           are the traces, second dimension the sampling
           points within the traces.") new_window_matrix;
void new_window_matrix( double* inarr, int traces, int size );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) new_window_selected_this;
%feature("docstring", "Creates a new window showing the
selected traces of the current file.
Returns:
True if successful.") new_window_selected_this;
bool new_window_selected_this( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) new_window_selected_all;
%feature("docstring", "Creates a new window showing the
selected traces of all open files.
Returns:
True if successful.") new_window_selected_all;
bool new_window_selected_all( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) show_table;
%feature("docstring", "Shows a python dictionary in a results table.
The dictionary has to have the form \"string\" : float

Arguments:
dict --    A dictionary with strings as key values and floating point
           numbers as values.
caption -- An optional caption for the table.

Returns:
True if successful.") show_table;
bool show_table( PyObject* dict, const char* caption = "Python table" );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) show_table_dictlist;
%feature("docstring", "Shows a python dictionary in a results table.
The dictionary has to have the form \"string\" : list. 

Arguments:
dict --    A dictionary with strings as key values and lists of 
           floating point numbers as values.
caption -- An optional caption for the table.
reverse -- If True, The table will be filled in column-major order,
           i.e. dictionary keys will become column titles. Setting
           it to False has not been implemented yet.

Returns:
True if successful.") show_table_dictlist;
bool show_table_dictlist( PyObject* dict, const char* caption = "Python table", bool reverse = true );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_size_trace;
%feature("docstring", "Retrieves the number of sample points of a trace.
   
Arguments:
trace --   ZERO-BASED index of the trace. Default value of -1
           will use the currently displayed trace. Note that
           this is one less than what is displayed in the drop-
           down list.
channel -- ZERO-BASED index of the channel. Default value of
           -1 will use the current channel.
Returns:
The number of sample points.") get_size_trace;
int get_size_trace( int trace = -1, int channel = -1 );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_size_channel;
%feature("docstring", "Retrieves the number of traces in a channel.
Note that at present, stimfit only supports equal-sized channels, i.e. 
all channels within a file need to have the same number of traces. The
channel argument is only for future extensions. 
   
Arguments:
channel -- ZERO-BASED index of the channel. Default value of
           -1 will use the current channel. 
Returns:
The number traces in a channel.") get_size_channel;
int get_size_channel( int channel = -1 );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_sampling_interval;
%feature("docstring", "Returns the sampling interval.

Returns:
The sampling interval.") get_sampling_interval;
double get_sampling_interval( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_sampling_interval;
%feature("docstring", "Sets a new sampling interval.

Argument:
si --     The new sampling interval.

Returns:
False upon failure.") set_sampling_interval;
bool set_sampling_interval( double si );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) select_trace;
%feature("docstring", "Selects a trace. Checks for out-of-range
indices and stores the baseline along with the trace index.
   
Arguments:
trace --   ZERO-BASED index of the trace. Default value of -1
           will select the currently displayed trace. Note that
           this is one less than what is displayed in the drop-
           down list.
Returns:
True if the trace could be selected, False otherwise.") select_trace;
bool select_trace( int trace = -1 );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) select_all;
%feature("docstring", "Selects all traces in the current file. Stores 
the baseline along with the trace index.") select_all;
void select_all( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) unselect_all;
%feature("docstring", "Unselects all previously selected traces in the
current file.") unselect_all;
void unselect_all( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) subtract_base;
%feature("docstring", "Subtracts the baseline from the selected traces
of the current file, then displays the subtracted
traces in a new window.

Returns:
True if the subtraction was successful, False otherwise.") subtract_base;
bool subtract_base( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) leastsq;
%feature("docstring", "Fits a function to the data between the current
fit cursors.

Arguments:
fselect -- Zero-based index of the function as it appears in the fit
           selection dialog.
refresh -- To avoid flicker during batch analysis, this may be set to
           False so that the fitted function will not immediately
           be drawn.

Returns:
A dictionary with the best-fit parameters and the least-squared
error, or a null pointer upon failure.") leastsq;
PyObject* leastsq( int fselect, bool refresh = true );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) leastsq_param_size;
%feature("docstring", "Retrieves the number of parameters for a
function.

Arguments:
fselect -- Zero-based index of the function as it appears in the fit
           selection dialog.

Returns:
The number of parameters for the function with index fselect, or a 
negative value upon failure.") leastsq_param_size;
int leastsq_param_size( int fselect );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) check_doc;
%feature("docstring", "Checks whether a file is open.

Returns:
True if a file is open, False otherwise.") check_doc;
bool check_doc( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) _gVector_resize;
%feature("docstring", "Resizes the global vector. Do not use directly.
   
Arguments:
size -- New size of the global vector.") _gVector_resize;
void _gVector_resize( std::size_t size );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) _gVector_at;
%feature("docstring", "Sets the valarray at the specified position of
the global vector. Do not use directly.
Arguments:
invec -- The NumPy array to be used.
at --    The position within the global vector.") _gVector_at;
void _gVector_at( double* invec, int size, int at );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) file_open;
%feature("docstring", "Opens a file.
   
Arguments:
filename -- The file to be opened. On Windows, use double back-
            slashes (\"\\\\\\\\\") between directories to avoid con-
            version to special characters such as \"\\\\t\" or \"\\\\n\".
            Example usage in Windows:
            file_open(\"C:\\\\\\data\\\\\\datafile.dat\")
            Example usage in Linux:
            file_open(\"/home/cs/data/datafile.dat\")
            This is surprisingly slow when called from python. 
            Haven't figured out the reason yet.

Returns:
True if the file could be opened, False otherwise.") file_open;
bool file_open( const char* filename );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) file_save;
%feature("docstring", "Saves a file.
   
Arguments:
filename -- The file to be saved. On Windows, use double back-
            slashes (\"\\\\\\\\\") between directories to avoid con-
            version to special characters such as \"\\\\t\" or \"\\\\n\".
            Example usage in Windows:
            file_save(\"C:\\\\\\data\\\\\\datafile.dat\")
            Example usage in Linux:
            file_save(\"/home/cs/data/datafile.dat\")
            This is surprisingly slow when called from python. 
            Haven't figured out the reason yet.

Returns:
True if the file could be saved, False otherwise.") file_save;
bool file_save( const char* filename );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) close_all;
%feature("docstring", "Closes all open files.
   
Returns:
True if all files could be closed.") close_all;
bool close_all( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) close_this;
%feature("docstring", "Closes the currently active file.
   
Returns:
True if the file could be closed.") close_this;
bool close_this( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_base;
%feature("docstring", "Returns the current baseline value. Uses the 
currently measured values, i.e. does not update measurements if the 
peak or base window cursors have changed.
         
Returns:
The current baseline.") get_base;
double get_base( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_peak;
%feature("docstring", "Returns the current peak value, measured from
zero (!). Uses the currently measured values, i.e. does not update 
measurements if the peak or base window cursors have changed.
         
Returns:
The current peak value, measured from zero (again: !).") get_peak;
double get_peak( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) peak_index;
%feature("docstring", "Returns the zero-based index of the current
peak position in the specified channel. Uses the currently measured
values, i.e. does not update measurements if the peak window cursors
have changed.
   
Arguments:
active -- If True, returns the current peak index of the active channel.
          Otherwise, returns the current peak index of the inactive channel.
          
Returns:
The zero-based index in units of sampling points. May be interpolated
if more than one point is used for the peak calculation. Returns a 
negative value upon failure.") peak_index;
%callback("%s_cb");
double peak_index( bool active = true );
%nocallback;
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) maxrise_index;
%feature("docstring", "Returns the zero-based index of the maximal
slope of rise in the specified channel. Uses the currently measured
values, i.e. does not update measurements if the peak window cursors
have changed.
   
Arguments:
active -- If True, returns the current index of the maximal slope of 
          rise within the active channel. Otherwise, returns the 
          current index of the maximal slope of rise within the 
          inactive channel.
          
Returns:
The zero-based index of the maximal slope of  rise in units of 
sampling points. Interpolated between adjacent sampling points.
Returns a negative value upon failure.") maxrise_index;
%callback("%s_cb");
double maxrise_index( bool active = true );
%nocallback;
//--------------------------------------------------------------------


//--------------------------------------------------------------------
%feature("autodoc", 0) foot_index;
%feature("docstring", "Returns the zero-based index of the foot of 
an event in the active channel. The foot is the intersection of an
interpolated line through the points of 20 and 80% rise with the
baseline. Uses the currently measured values, i.e. does not update 
measurements if the peak or base window cursors have changed.
   
Arguments:
active -- If True, returns the current index of the foot within the 
          active channel. Only implemented for the active channel
          at this time. Will return a negative value and show an 
          error message if active == False.
          
Returns:
The zero-based index of the foot of an event in units of sampling 
points. Interpolates between sampling points.
Returns a negative value upon failure.") foot_index;
%callback("%s_cb");
double foot_index( bool active = true );
%nocallback;
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) t50left_index;
%feature("docstring", "Returns the zero-based index of the left half-
maximal amplitude of an event in the specified channel. Uses the 
currently measured values, i.e. does not update measurements if the 
peak or base window cursors have changed.
   
Arguments:
active -- If True, returns the current index of the left half-
          maximal amplitude within the active channel. If False, 
          returns the current index of the left half-maximal amplitude
          within the inactive channel.
          
Returns:
The zero-based index of the left half-maximal amplitude in units of 
sampling points. Interpolates between sampling points. Returns a 
negative value upon failure.") t50left_index;
%callback("%s_cb");
double t50left_index( bool active = true );
%nocallback;
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) t50right_index;
%feature("docstring", "Returns the zero-based index of the right half-
maximal amplitude of an event in the active channel. Uses the 
currently measured values, i.e. does not update measurements if the 
peak or base window cursors have changed.
   
Arguments:
active -- If True, returns the current index of the right half-
          maximal amplitude within the active channel. Only 
          implemented for the active channel at this time. Will return 
          a negative value and show an error message if 
          active == False.
          
Returns:
The zero-based index of the right half-maximal amplitude in units of 
sampling points. Interpolates between sampling points. Returns a 
negative value upon failure.") t50right_index;
%callback("%s_cb");
double t50right_index( bool active = true );
%nocallback;
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_fit_start;
%feature("docstring", "Returns the zero-based index or the time point
of the fit start cursor.

Arguments:
is_time -- If False (default), returns the zero-based index. If True,
           returns the time from the beginning of the trace to the
           cursor position.          
") get_fit_start;
double get_fit_start( bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_fit_end;
%feature("docstring", "Returns the zero-based index or the time point
of the fit end cursor.

Arguments:
is_time -- If False (default), returns the zero-based index. If True,
           returns the time from the beginning of the trace to the
           cursor position.          
") get_fit_end;
double get_fit_end( bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_fit_start;
%feature("docstring", "Sets the fit start cursor to a new position.

Arguments:
pos --     The new cursor position, either in units of sampling points
           if is_time == False (default) or in units of time if
           is_time == True.
is_time -- see above.

Returns:
False upon failure (such as out-of-range).") set_fit_start;
bool set_fit_start( double pos, bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_fit_end;
%feature("docstring", "Sets the fit end cursor to a new position.

Arguments:
pos --     The new cursor position, either in units of sampling points
           if is_time == False (default) or in units of time if
           is_time == True.
is_time -- see above.

Returns:
False upon failure (such as out-of-range).") set_fit_end;
bool set_fit_end( double pos, bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_peak_start;
%feature("docstring", "Returns the zero-based index or the time point
of the peak start cursor.

Arguments:
is_time -- If False (default), returns the zero-based index. If True,
           returns the time from the beginning of the trace to the
           cursor position.          
") get_peak_start;
double get_peak_start( bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_peak_end;
%feature("docstring", "Returns the zero-based index or the time point
of the peak end cursor.

Arguments:
is_time -- If False (default), returns the zero-based index. If True,
           returns the time from the beginning of the trace to the
           cursor position.          
") get_peak_end;
double get_peak_end( bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_peak_start;
%feature("docstring", "Sets the peak start cursor to a new position.
This will NOT update the peak calculation. You have to either call 
measure() or hit enter in the main window to achieve that.

Arguments:
pos --     The new cursor position, either in units of sampling points
           if is_time == False (default) or in units of time if
           is_time == True.
is_time -- see above.

Returns:
False upon failure (such as out-of-range).") set_peak_start;
bool set_peak_start( double pos, bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_peak_end;
%feature("docstring", "Sets the peak end cursor to a new position.
This will NOT update the peak calculation. You have to either call 
measure() or hit enter in the main window to achieve that.

Arguments:
pos --     The new cursor position, either in units of sampling points
           if is_time == False (default) or in units of time if
           is_time == True.
is_time -- see above.

Returns:
False upon failure (such as out-of-range).") set_peak_end;
bool set_peak_end( double pos, bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_peak_mean;
%feature("docstring", "Sets the number of points used for the peak 
calculation.

Arguments:
pts -- A moving average (aka sliding, boxcar or running average) is 
       used to determine the peak value. Pts specifies the number of
       sampling points used for the moving window.
       Passing a value of -1 will calculate the average of all
       sampling points within the peak window.

Returns:
False upon failure (such as out-of-range).") set_peak_mean;
bool set_peak_mean( int pts );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_peak_direction;
%feature("docstring", "Sets the direction of the peak detection.

Arguments:
direction -- A string specifying the peak direction. Can be one of:
             \"up\", \"down\" or \"both\"

Returns:
False upon failure.") set_peak_direction;
bool set_peak_direction( const char* direction );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_base_start;
%feature("docstring", "Returns the zero-based index or the time point
of the base start cursor.

Arguments:
is_time -- If False (default), returns the zero-based index. If True,
           returns the time from the beginning of the trace to the
           cursor position.") get_base_start;
double get_base_start( bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_base_end;
%feature("docstring", "Returns the zero-based index or the time point
of the base end cursor.

Arguments:
is_time -- If False (default), returns the zero-based index. If True,
           returns the time from the beginning of the trace to the
           cursor position.") get_base_end;
double get_base_end( bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_base_start;
%feature("docstring", "Sets the base start cursor to a new position.
This will NOT update the baseline calculation. You have to either call 
measure() or hit enter in the main window to achieve that.

Arguments:
pos --     The new cursor position, either in units of sampling points
           if is_time == False (default) or in units of time if
           is_time == True.
is_time -- see above.

Returns:
False upon failure (such as out-of-range).") set_base_start;
bool set_base_start( double pos, bool is_time = false );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_base_end;
%feature("docstring", "Sets the base end cursor to a new position.
This will NOT update the baseline calculation. You have to either call 
measure() or hit enter in the main window to achieve that.

Arguments:
pos --     The new cursor position, either in units of sampling points
           if is_time == False (default) or in units of time if
           is_time == True.
is_time -- see above.

Returns:
False upon failure (such as out-of-range).") set_base_end;
bool set_base_end( double pos, bool is_time = false );
//--------------------------------------------------------------------


//--------------------------------------------------------------------
%feature("autodoc", 0) measure;
%feature("docstring", "Updates all measurements (e.g. peak, baseline, 
latency) according to the current cursor settings. As if you had
pressed \"Enter\" in the main window.
Returns:
False upon failure, True otherwise.") measure;
bool measure( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_selected_indices;
%feature("docstring", "Returns a tuple with the indices (ZERO-BASED) 
of the selected traces.") get_selected_indices;
PyObject* get_selected_indices( );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_trace;
%feature("docstring", "Sets the currently displayed trace to a new
index. Subsequently updates all measurements (e.g. peak, base,
latency, i.e. you don't need to call measure() yourself.)

Arguments:
trace -- The zero-based index of the new trace to be displayed.

Returns:
True upon success, false otherwise (such as out-of-range).") set_trace;
bool set_trace( int trace );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_trace_index;
%feature("docstring", "Returns the ZERO-BASED index of the currently
displayed trace (this is one less than what is shown in the combo box).
") get_trace_index;
int get_trace_index();
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) get_channel_index;
%feature("docstring", "Returns the ZERO-BASED index of the specified
channel.

Arguments:

active -- If True, returns the index of the active (black) channel.
If False, returns the index of the inactive (red) channel.
") get_channel_index;
int get_channel_index( bool active = true );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) align_selected;
%feature("docstring", "Aligns the selected traces to the index that is 
returned by the alignment function, and then creates a new window 
showing the aligned traces.
Arguments:       
alignment -- The alignment function to be used. Accepts any function
             returning a valid index within a trace. These are some
             predefined possibilities:
             maxrise_index (default; maximal slope during rising phase)
             peak_index (Peak of an event)
             foot_index (Beginning of an event)
             t50left_index 
             t50right_index (Left/right half-maximal amplitude)
active --    If True, the alignment function will be applied to
             the active channel. If False (default), it will be applied
             to the inactive channel.
zeropad --   Not yet implemented:
             If True, missing parts at the beginning or end of a trace 
             will be padded with zeros after the alignment. If False
             (default), traces will be cropped so that all traces have
             equal sizes.
") align_selected;
void align_selected(  double (*alignment)( bool ), bool active = false );

//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) set_marker;
%feature("docstring", "Sets a marker to the specified position in the
current trace.

Arguments:
x -- The horizontal marker position in units of sampling points.
y -- The vertical marker position in measurement units (e.g. mV).

Returns:
False upon failure (such as out-of-range).") set_marker;
bool set_marker( double x, double y );
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%feature("autodoc", 0) erase_markers;
%feature("docstring", "Erases all markers in the current trace.

Returns:
False upon failure.") erase_marker;
bool erase_markers();
//--------------------------------------------------------------------

//--------------------------------------------------------------------
%pythoncode {
import numpy as N

def get_trace(trace = -1, channel = -1):
    """Returns a trace as a 1-dimensional NumPy array.
      
    Arguments:       
    trace --   ZERO-BASED index of the trace within the channel.
               Note that this is one less than what is shown
               in the drop-down box.
               The default value of -1 returns the currently
               displayed trace.
    channel -- ZERO-BASED index of the channel. This is independent
               of whether a channel is active or not.
               The default value of -1 returns the currently
               active channel.
    Returns:
    The trace as a 1D NumPy array.
    """
    return _get_trace_fixedsize(get_size_trace(trace, channel), trace, channel)
    
def new_window_list( array_list ):
    """Creates a new window showing a list of
    1D NumPy arrays. As opposed to new_window_matrix(), this
    has the advantage that the arrays need not have equal sizes.
      
    Arguments:       
    array_list -- A tuple of numpy arrays.
    """

    _gVector_resize( len(array_list) )
    n = 0
    for a in array_list:
        _gVector_at( a, n )
        n = n+1

    _new_window_gVector( )

def cut_traces( pt ):
    """Cuts the selected traces at the sampling point pt,
    and shows the cut traces in a new window.
    Returns True upon success, False upon failure."""
    
    if not get_selected_indices():
        return False
    new_list = list()
    for n in get_selected_indices():
        if not set_trace(n): return False
        
        if pt < get_size_trace():
            new_list.append( get_trace()[:pt] )
            new_list.append( get_trace()[pt:] )
        else:
            print "Cutting point", pt, "is out of range"

    if len(new_list) > 0: new_window_list( new_list )
    
    return True
    
def cut_traces_multi( pt_list ):
    """Cuts the selected traces at the sampling points
    in pt_list and shows the cut traces in a new window.
    Returns True upon success, False upon failure."""
    if not get_selected_indices():
        return False
    new_list = list()
    for n in get_selected_indices():
        if not set_trace(n): return False
        old_pt = 0
        for pt in pt_list:
            if pt < get_size_trace():
                new_list.append( get_trace()[old_pt:pt] )
                old_pt = pt
            else:
                print "Cutting point", pt, "is out of range"
        if len(new_list) > 0: new_list.append( get_trace()[old_pt:] )
    new_window_list( new_list )
    return True
}
//--------------------------------------------------------------------