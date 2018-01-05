/**
 * allows for downloading of grid data (store) directly into excel
 * Method: extracts data of gridPanel store, uses columnModel to construct XML excel document,
 * converts to Base64, then loads everything into a data URL link.
 *
 * @author		Animal		<extjs support team>
 *
 */

function importExcel()
{
	var param = new Object();
	param.title = "test";
	var xlsFile = $('#dg').datagrid('getExcelXml', param );
	saveAsXML( xlsFile );
}

function saveAsXML( xlsFile ) {
	var b = window.open("", "", "height=100, width=100, toolbar= no, menubar=no, scrollbars=no,resizable=no, location=no, status=no,top=center,left=center");
	b.document.open();
	b.document.write( xlsFile );
	/*for( ;b.document.readyState != "complete"; ) { 
	    if ( b.document.readyState == "complete" )
	    	break; 
	}*/ 
	//b.document.close();
	b.document.execCommand('SaveAs','false','*.xls');
	b.window.close();	
}

/*$.extend($.fn.datagrid.methods,{
    getExcelXml: function(jq, param) {
        var worksheet = this.createWorksheet(jq, param);
		//alert($(jq).datagrid('getColumnFields'));
		var totalWidth = 0;
		var cfs = $(jq).datagrid('getColumnFields');
		for(var i=1; i<cfs.length; i++) {
			totalWidth+= $(jq).datagrid('getColumnOption',cfs[i]).width;
		}
        //var totalWidth = this.getColumnModel().getTotalWidth(includeHidden);
        var result = '<xml version="1.0" encoding="utf-8">';
        result += '<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:o="urn:schemas-microsoft-com:office:office">';
        result += '<o:DocumentProperties><o:Title>' + param.title + '</o:Title></o:DocumentProperties>';
        result += '<ss:ExcelWorkbook>';
        result += '<ss:WindowHeight>' + worksheet.height + '</ss:WindowHeight>';
        result += '<ss:WindowWidth>' + worksheet.width + '</ss:WindowWidth>';
        result += '<ss:ProtectStructure>False</ss:ProtectStructure>';
        result += '<ss:ProtectWindows>False</ss:ProtectWindows>';
        result += '</ss:ExcelWorkbook>';
        result += '<ss:Styles>';
        result += '<ss:Style ss:ID="Default">';
        result += '<ss:Alignment ss:Vertical="Top"  />';
        result += '<ss:Font ss:FontName="arial" ss:Size="10" />';
        result += '<ss:Borders>';
        result += '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Top" />';
        result += '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Bottom" />';
        result += '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Left" />';
        result += '<ss:Border ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Right" />';
        result += '</ss:Borders>';
        result += '<ss:Interior />';
        result += '<ss:NumberFormat />';
        result += '<ss:Protection />';
        result += '</ss:Style>';
        result += '<ss:Style ss:ID="title">';
        result += '<ss:Borders />';
        result += '<ss:Font />';
        result += '<ss:Alignment  ss:Vertical="Center" ss:Horizontal="Center" />';
        result += '<ss:NumberFormat ss:Format="@" />';
        result += '</ss:Style>';
        result += '<ss:Style ss:ID="headercell">';
        result += '<ss:Font ss:Bold="1" ss:Size="10" />';
        result += '<ss:Alignment  ss:Horizontal="Center" />';
        result += '<ss:Interior ss:Pattern="Solid"  />';
        result += '</ss:Style>';
        result += '<ss:Style ss:ID="even">';
        result += '<ss:Interior ss:Pattern="Solid"  />';
        result += '</ss:Style>';
        result += '<ss:Style ss:Parent="even" ss:ID="evendate">';
        result += '<ss:NumberFormat ss:Format="yyyy-mm-dd" />';
        result += '</ss:Style>';
        result += '<ss:Style ss:Parent="even" ss:ID="evenint">';
        result += '<ss:NumberFormat ss:Format="0" />';
        result += '</ss:Style>';
        result += '<ss:Style ss:Parent="even" ss:ID="evenfloat">';
        result += '<ss:NumberFormat ss:Format="0.00" />';
        result += '</ss:Style>';
        result += '<ss:Style ss:ID="odd">';
        result += '<ss:Interior ss:Pattern="Solid"  />';
        result += '</ss:Style>';
        result += '<ss:Style ss:Parent="odd" ss:ID="odddate">';
        result += '<ss:NumberFormat ss:Format="yyyy-mm-dd" />';
        result += '</ss:Style>';
        result += '<ss:Style ss:Parent="odd" ss:ID="oddint">';
        result += '<ss:NumberFormat ss:Format="0" />';
        result += '</ss:Style>';
        result += '<ss:Style ss:Parent="odd" ss:ID="oddfloat">';
        result += '<ss:NumberFormat ss:Format="0.00" />';
        result += '</ss:Style>';
        result += '</ss:Styles>';
        result += worksheet.xml;
        result += '</ss:Workbook>';
        return result;
    },

    createWorksheet: function(jq, param) {
        // Calculate cell data types and extra class names which affect formatting
        var cellType = [];
        var cellTypeClass = [];
        //var cm = this.getColumnModel();
        var totalWidthInPixels = 0;
        var colXml = '';
        var headerXml = '';
        var visibleColumnCountReduction = 0;
		var cfs = $(jq).datagrid('getColumnFields');
        var colCount = cfs.length;
        for (var i = 1; i < colCount; i++) {
            if (cfs[i] != '') {
                var w = $(jq).datagrid('getColumnOption',cfs[i]).width;
                totalWidthInPixels += w;
                if (cfs[i] === ""){
                	cellType.push("None");
                	cellTypeClass.push("");
                	++visibleColumnCountReduction;
                }
                else
                {
                    colXml += '<ss:Column ss:AutoFitWidth="1" ss:Width="130" />';
                    headerXml += '<ss:Cell ss:StyleID="headercell">' +
                        '<ss:Data ss:Type="String">' + $(jq).datagrid('getColumnOption',cfs[i]).title + '</ss:Data>' +
                        '<ss:NamedCell ss:Name="Print_Titles" /></ss:Cell>';
					cellType.push("String");
                    cellTypeClass.push("");
                }
            }
        }
        var visibleColumnCount = cellType.length - visibleColumnCountReduction;

        var result = {
            height: 9000,
            width: Math.floor(totalWidthInPixels * 30) + 50
        };
		
		var rows = $(jq).datagrid('getRows');
        // Generate worksheet header details.
        var t = '<ss:Worksheet ss:Name="' + param.title + '">' +
            '<ss:Names>' +
            '<ss:NamedRange ss:Name="Print_Titles" ss:RefersTo="=\'' + param.title + '\'!R1:R2" />' +
            '</ss:Names>' +
            '<ss:Table x:FullRows="1" x:FullColumns="1"' +
            ' ss:ExpandedColumnCount="' + (visibleColumnCount + 2) +
            '" ss:ExpandedRowCount="' + (rows.length + 2) + '">' +
            colXml +
            '<ss:Row ss:AutoFitHeight="1">' +
            headerXml +
            '</ss:Row>';

        // Generate the data rows from the data in the Store
        //for (var i = 0, it = this.store.data.items, l = it.length; i < l; i++) {
        for (var i = 0, it = rows, l = it.length; i < l; i++) {
            t += '<ss:Row>';
            var cellClass = (i & 1) ? 'odd' : 'even';
            r = it[i];
            var k = 0;
            for (var j = 1; j < colCount; j++) {
                //if ((cm.getDataIndex(j) != '')
                if (cfs[j] != '') {
                    //var v = r[cm.getDataIndex(j)];
                    var v = r[cfs[j]];
                    if (cellType[k] !== "None") {
                        t += '<ss:Cell ss:StyleID="' + cellClass + cellTypeClass[k] + '"><ss:Data ss:Type="' + cellType[k] + '">';
                        if (cellType[k] == 'DateTime') {
                            t += v.format('Y-m-d');
                        } else {
                            t += v;
                        }
                        t +='</ss:Data></ss:Cell>';
                    }
                    k++;
                }
            }
            t += '</ss:Row>';
        }

        result.xml = t + '</ss:Table>' +
            '<x:WorksheetOptions>' +
            '<x:PageSetup>' +
            '<x:Layout x:CenterHorizontal="1" x:Orientation="Landscape" />' +
            '<x:Footer x:Data="Page &amp;P of &amp;N" x:Margin="0.5" />' +
            '<x:PageMargins x:Top="0.5" x:Right="0.5" x:Left="0.5" x:Bottom="0.8" />' +
            '</x:PageSetup>' +
            '<x:FitToPage />' +
            '<x:Print>' +
            '<x:PrintErrors>Blank</x:PrintErrors>' +
            '<x:FitWidth>1</x:FitWidth>' +
            '<x:FitHeight>32767</x:FitHeight>' +
            '<x:ValidPrinterInfo />' +
            '<x:VerticalResolution>600</x:VerticalResolution>' +
            '</x:Print>' +
            '<x:Selected />' +
            '<x:DoNotDisplayGridlines />' +
            '<x:ProtectObjects>False</x:ProtectObjects>' +
            '<x:ProtectScenarios>False</x:ProtectScenarios>' +
            '</x:WorksheetOptions>' +
            '</ss:Worksheet>';
			//alert(result.xml);
        return result;
    }
});*/

