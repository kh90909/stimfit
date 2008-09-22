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

/*! \file smalldlgs.h
 *  \author Christoph Schmidt-Hieber
 *  \date 2008-01-16
 *  \brief Declares several small dialogs.
 */

#ifndef _SMALLDLGS_H
#define _SMALLDLGS_H

/*! \addtogroup wxstf
 *  @{
 */

#include <vector>
#include "./../../core/stimdefs.h"

//! Dialog showing file information.
class wxStfFileInfoDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    wxStdDialogButtonSizer* m_sdbSizer;

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param szGeneral General information.
     *  \param szFile File variables information.
     *  \param szSection Section variable information.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfFileInfoDlg(
            wxWindow* parent,
            const wxString& szGeneral=wxT("\0"),
            const wxString& szFile=wxT("\0"),
            const wxString& szSection=wxT("\0"),
            int id = wxID_ANY,
            wxString title = wxT("File information"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

};

//! Dialog for selecting channels
class wxStfChannelSelDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    int m_selChannel1, m_selChannel2;
    wxStdDialogButtonSizer* m_sdbSizer;
    wxComboBox *m_comboBoxCh1,*m_comboBoxCh2;

    void OnComboCh1( wxCommandEvent& event );
    void OnComboCh2( wxCommandEvent& event );

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param channelNames A vector containing the channel names.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfChannelSelDlg(
            wxWindow* parent,
            const std::vector<wxString>& channelNames=
                std::vector<wxString>(0),
                int id = wxID_ANY,
                wxString title = wxT("Select channels"),
                wxPoint pos = wxDefaultPosition,
                wxSize size = wxDefaultSize,
                int style = wxCAPTION
    );
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);

    //! Get selection for channel 1
    /*! \return The index of the first (active) channel
     */
    int GetSelCh1() const {return m_selChannel1;}

    //! Get selection for channel 2
    /*! \return The index of the second (inactive) channel
     */
    int GetSelCh2() const {return m_selChannel2;}
};

//! Dialog for selecting alignment mode
class wxStfAlignDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    bool m_alignRise;
    wxRadioBox* m_radioBox;
    wxStdDialogButtonSizer* m_sdbSizer;

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfAlignDlg(
            wxWindow* parent,
            int id = wxID_ANY,
            wxString title = wxT("Alignment mode"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

    //! Indicates whether the average should be aligned to the steepest rise.
    /*!  \return true if it should be aligned to the steepest rise, false if it should be
     *           aligned to the peak.
     */
    bool AlignRise() const {return m_alignRise;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

//! Dialog for selecting a filter function
class wxStfFilterSelDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    int m_filterSelect;
    wxRadioBox* m_radioBox;
    wxStdDialogButtonSizer* m_sdbSizer;

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfFilterSelDlg(
            wxWindow* parent,
            int id = wxID_ANY,
            wxString title = wxT("Filter function"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

    //! Get the selected filter function.
    /*! \return The index of the selected filter function.
     */
    int GetFilterSelect() const {return m_filterSelect;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

//! Dialog for selecting a transform function
class wxStfTransformDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    int m_fSelect;
    wxRadioBox* m_radioBox;
    wxStdDialogButtonSizer* m_sdbSizer;

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfTransformDlg(
            wxWindow* parent,
            int id = wxID_ANY,
            wxString title = wxT("Choose function"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

    //! Get the selected transform function.
    /*! \return The index of the selected transform function.
     */
    int GetFSelect() const {return m_fSelect;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

//! Dialog showing information about a fit.
class wxStfFitInfoDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    wxStdDialogButtonSizer* m_sdbSizer;

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param info A string containing information about the fit.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfFitInfoDlg(
            wxWindow* parent,
            const wxString& info,
            int id = wxID_ANY,
            wxString title = wxT("Fit information"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );
};

//! Dialog for batch analysis settings.
class wxStfBatchDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    bool m_PrintAmp;
    bool m_PrintBase;
    bool m_PrintBaseSD;
    bool m_PrintPeak;
    bool m_PrintRt2080;
    bool m_PrintThalf;
    bool m_PrintSlope;
    bool m_PrintThr;
    bool m_PrintLatencies;
    bool m_PrintFitResults;
    wxCheckListBox*	m_checkList;	
    wxStdDialogButtonSizer* m_sdbSizer;

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfBatchDlg(
            wxWindow* parent,
            int id = wxID_ANY,
            wxString title = wxT("Choose values"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

    //! Indicates whether the amplitude should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintAmp() const {return m_PrintAmp;}

    //! Indicates whether the baseline should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintBase() const {return m_PrintBase;}

    //! Indicates whether the standard deviation of the baseline should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintBaseSD() const {return m_PrintBaseSD;}

    //! Indicates whether the peak value should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintPeak() const {return m_PrintPeak;}

    //! Indicates whether the 20-80% rise time should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintRT2080() const {return m_PrintRt2080;}

    //! Indicates whether the half duration should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintT50() const {return  m_PrintThalf;}

    //! Indicates whether the maximal slopes should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintSlope() const {return  m_PrintSlope;}

    //! Indicates whether a threshold crossing should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintThr() const {return m_PrintThr;}

    //! Indicates whether the latency should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintLatencies() const {return m_PrintLatencies;}

    //! Indicates whether the fit results should be printed in the batch analysis table.
    /*! \return true if it should be printed, false otherwise.
     */
    bool PrintFitResults() const {return m_PrintFitResults;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

//! Dialog for setting printout options.
class wxStfPreprintDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    bool m_gimmicks,m_isFile;
    int m_downsampling;
    wxStdDialogButtonSizer* m_sdbSizer;
    wxCheckBox* m_checkBox;
    wxTextCtrl* m_textCtrl;

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param isFile Set this to true if something should be printed to a file.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfPreprintDlg(
            wxWindow* parent,
            bool isFile=false,
            int id = wxID_ANY,
            wxString title = wxT("Settings"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

    //! Indicates whether gimmicks (cursors, results table etc.) sould be printed.
    /*! \return true if gimmicks should be printed.
     */
    bool GetGimmicks() const {return m_gimmicks;}
    
    //! Prints every n-th point.
    /*! \return If the return value \e n > 1, every <em>n</em>-th point will be printed.
     */
    int GetDownSampling() const {return m_downsampling;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

//! Dialog for setting the parameters of a Gaussian function.
class wxStfGaussianDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    double m_width;
    double m_center;
    double m_amp;
    wxStdDialogButtonSizer* m_sdbSizer;
    wxSlider* m_slider;
    wxTextCtrl *m_textCtrlCenter, *m_textCtrlWidth;

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfGaussianDlg(
            wxWindow* parent,
            int id = wxID_ANY,
            wxString title = wxT("Settings for Gaussian function"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

    //! Get the width of the Gaussian.
    /*! \return The width of the Gaussian.
     */
    double Width() const {return m_width;}

    //! Get the center of the Gaussian.
    /*! \return The center of the Gaussian.
     */
    double Center() const {return m_center;}

    //! Get the amplitude of the Gaussian.
    /*! \return The amplitude of the Gaussian.
     */
    double Amp() const {return m_amp;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

//! Dialog for text import filter settings.
class wxStfTextImportDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    int m_hLines;
    bool m_toSection;
    bool m_firstIsTime;
    bool m_isSeries;
    int m_ncolumns;
    double m_sr;
    wxString m_yUnits;
    wxString m_yUnitsCh2;
    wxString m_xUnits;
    bool m_applyToAll;

    void disableSenseless();

    wxStdDialogButtonSizer* m_sdbSizer;
    wxTextCtrl *m_textCtrlHLines, *m_textCtrlYUnits, *m_textCtrlYUnitsCh2,
    *m_textCtrlXUnits, *m_textCtrlSR;
    wxComboBox *m_comboBoxNcolumns,*m_comboBoxFirsttime,*m_comboBoxSecorch;
    wxCheckBox *m_checkBoxApplyToAll;
    void OnComboNcolumns( wxCommandEvent& event );
    void OnComboFirsttime( wxCommandEvent& event );
    void OnComboSecorch( wxCommandEvent& event ); 

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param textPreview The preview text to be shown.
     *  \param hLines_ The number of header lines that are initially set.
     *  \param isSeries Set this to true for file series so that they can
     *         be batch-opened.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfTextImportDlg(
            wxWindow* parent,
            const wxString& textPreview=wxT("\0"),
            int hLines_=1,
            bool isSeries=false,
            int id = wxID_ANY,
            wxString title = wxT("Text file import settings"),
            wxPoint pos = wxDefaultPosition,
            wxSize size = wxDefaultSize,
            int style = wxCAPTION
    );

    //! Get the number of header lines.
    /*! \return The number of header lines.
     */
    int GetHLines() const {return m_hLines;}

    //! Indicates whether columns should be put into section or into channels.
    /*! \return true if they should be put into sections.
     */
    bool ToSection() const {return m_toSection;}

    //! Indicates whether the first column contains time values.
    /*! \return true is the first column contains time values.
     */
    bool FirstIsTime() const {return m_firstIsTime;}

    //! Get the number of columns.
    /*! \return The number of columns.
     */
    int GetNColumns() const {return m_ncolumns;}

    //! Get the sampling rate.
    /*! \return The sampling rate.
     */
    double GetSR() const {return m_sr;}

    //! Get the y units of the first channel.
    /*! \return The y units of the first channel.
     */
    const wxString& GetYUnits() const {return m_yUnits;}

    //! Get the y units of the second channel.
    /*! \return The y units of the second channel.
     */
    const wxString& GetYUnitsCh2() const {return m_yUnitsCh2;}

    //! Get the x units.
    /*! \return The x units.
     */
    const wxString& GetXUnits() const {return m_xUnits;}

    //! Indicates whether the settings apply to all files in a series.
    /*! \return true if the settings apply to all files.
     */
    bool ApplyToAll() const {return m_applyToAll;}

    //! Get the text import filter settings struct.
    /*! \return The stf::txtImportSettings struct.
     */
    stf::txtImportSettings GetTxtImport() const;

    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

class wxDirPickerCtrl;

//! Dialog for batch conversion of files.from cfs to atf.
class wxStfConvertDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    wxDirPickerCtrl *m_srcDirPicker,*m_destDirPicker;
    wxTextCtrl *m_textCtrlSrcFilter;
    wxString srcDir,destDir,srcFilter;
    std::vector<wxString> srcFileNames;

    bool ReadPath(const wxString& path);

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfConvertDlg( wxWindow* parent, int id = wxID_ANY, wxString title = wxT("Convert CFS files"),
            wxPoint pos = wxDefaultPosition, wxSize size = wxDefaultSize, int style = wxCAPTION );

    //! Get the source directory.
    /*! \return The source directory.
     */
    wxString GetSrcDir() const {return srcDir;}

    //! Get the destination directory.
    /*! \return The destination directory.
     */
    wxString GetDestDir() const {return destDir;}

    //! Get the source extension filter.
    /*! \return The source extension filter.
     */
    wxString GetSrcFilter() const {return srcFilter;}

    //! Get the list of file names.
    /*! \return A vector with source file names.
     */
    std::vector<wxString> GetSrcFileNames() const {return srcFileNames;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

class wxListCtrl;

//! Dialog for re-ordering channels before saving to file
class wxStfOrderChannelsDlg : public wxDialog 
{
    DECLARE_EVENT_TABLE()

private:
    wxListCtrl* m_List;
    std::vector<int> channelOrder;

    void OnUparrow( wxCommandEvent& event );
    void OnDownarrow( wxCommandEvent& event );
    void SwapItems(long itemId1, long itemId2);

    //! Only called when a modal dialog is closed with the OK button.
    /*! \return true if all dialog entries could be read successfully
     */
    bool OnOK();

public:
    //! Constructor
    /*! \param parent Pointer to parent window.
     *  \param channelNames A vector containing channel names.
     *  \param id Window id.
     *  \param title Dialog title.
     *  \param pos Initial position.
     *  \param size Initial size.
     *  \param style Dialog style.
     */
    wxStfOrderChannelsDlg(
            wxWindow* parent,
            const std::vector<wxString>& channelNames=
                std::vector<wxString>(0),
                int id = wxID_ANY,
                wxString title = wxT("Re-order channels"),
                wxPoint pos = wxDefaultPosition,
                wxSize size = wxDefaultSize,
                int style = wxCAPTION
    );

    //! Get the new channel order.
    /*! \return A vector of newly ordered channel indices.
     */
    std::vector<int> GetChannelOrder() const {return channelOrder;}
    
    //! Called upon ending a modal dialog.
    /*! \param retCode The dialog button id that ended the dialog
     *         (e.g. wxID_OK)
     */
    virtual void EndModal(int retCode);
};

/* @} */

#endif