$.extend({

    createUploadIframe: function(id, uri)
    {
            //create frame
            var frameId = 'jUploadFrame' + id;
			var io = $('<iframe id="' + frameId + '" name="' + frameId + '" />').css({"position":"absolute","top":"-1000px","left":"-1000px"});
			$(document.body).append(io);
            return io            
    },
    createUploadForm: function(id, fileElementId)
    {
        //create form    
        var formId = 'jUploadForm' + id;
        var fileId = 'jUploadFile' + id;
        var form = $('<form  action="" method="POST" name="' + formId + '" id="' + formId + '" enctype="multipart/form-data"></form>');    
        var oldElement = $('#' + fileElementId);
        var newElement = $(oldElement).clone();
        $(oldElement).attr('id', fileId);
        $(oldElement).before(newElement);
        $(oldElement).appendTo(form);
        //set attributes
        $(form).css('position', 'absolute');
        $(form).css('top', '-1200px');
        $(form).css('left', '-1200px');
        $(form).appendTo('body');        
        return form;
    },

    ajaxFileUpload: function(s) {
        // TODO introduce global settings, allowing the client to modify them for all requests, not only timeout        
        s = $.extend({}, $.ajaxSettings, s);
        var id = new Date().getTime()        
        var form = $.createUploadForm(id, s.fileElementId);
        var io = $.createUploadIframe(id, s.secureuri);
        var frameId = 'jUploadFrame' + id;
        var formId = 'jUploadForm' + id;        
        // Watch for a new set of requests
        if ( s.global && ! $.active++ )
        {
            $.event.trigger( "ajaxStart" );
        }            
        var requestDone = false;
        // Create the request object
        var xml = {}   
        if ( s.global )
            $.event.trigger("ajaxSend", [xml, s]);
        // Wait for a response to come back
        var uploadCallback = function(isTimeout)
        {            
            var io = document.getElementById(frameId);
            try 
            {                
                if(io.contentWindow)
                {
                     xml.responseText = io.contentWindow.document.body?io.contentWindow.document.body.innerHTML:null;
                     xml.responseXML = io.contentWindow.document.XMLDocument?io.contentWindow.document.XMLDocument:io.contentWindow.document;
                     
                }else if(io.contentDocument)
                {
                     xml.responseText = io.contentDocument.document.body?io.contentDocument.document.body.innerHTML:null;
                    xml.responseXML = io.contentDocument.document.XMLDocument?io.contentDocument.document.XMLDocument:io.contentDocument.document;
                }                        
            }catch(e)
            {
                $.handleError(s, xml, null, e);
            }
            if ( xml || isTimeout == "timeout") 
            {                
                requestDone = true;
                var status;
                try {
                    status = isTimeout != "timeout" ? "success" : "error";
                    if ( status != "error" )
                    {
                        var data = $.uploadHttpData( xml, s.dataType ); 
                        if ( s.success )
                            s.success( data, status );
                        if( s.global )
                            $.event.trigger( "ajaxSuccess", [xml, s] );
                    } else
                        $.handleError(s, xml, status);
                } catch(e){
                    status = "error";
                    $.handleError(s, xml, status, e);
                }
                if( s.global )
                    $.event.trigger( "ajaxComplete", [xml, s] );
                if ( s.global && ! --$.active )
                    $.event.trigger( "ajaxStop" );
                if ( s.complete )
                    s.complete(xml, status);

                $(io).unbind()

                setTimeout(function(){
					try 
					{
						$(io).remove();
						$(form).remove();    
						
					} catch(e) 
					{
						$.handleError(s, xml, null, e);
					}                                    
				}, 100)
                xml = null
            }
        }
        // Timeout checker
        if ( s.timeout > 0 ) 
        {
            setTimeout(function(){
                // Check to see if the request is still happening
                if( !requestDone ) uploadCallback( "timeout" );
            }, s.timeout);
        }
        try 
        {
           // var io = $('#' + frameId);
            var form = $('#' + formId);
            $(form).attr('action', s.url);
            $(form).attr('method', 'POST');
            $(form).attr('target', frameId);
            if(form.encoding)
            {
                form.encoding = 'multipart/form-data';                
            }
            else
            {                
                form.enctype = 'multipart/form-data';
            }            
            $(form).submit();

        } catch(e) 
        {            
            $.handleError(s, xml, null, e);
        }
        if(window.attachEvent){
            document.getElementById(frameId).attachEvent('onload', uploadCallback);
        }
        else{
            document.getElementById(frameId).addEventListener('load', uploadCallback, false);
        }         
        return {abort: function () {}};    

    },
	handleError: function( s, xhr, status, e ) 		{
		if ( s.error ) {
			s.error.call( s.context || s, xhr, status, e );
		}
		if ( s.global ) {
			(s.context ? jQuery(s.context) : jQuery.event).trigger( "ajaxError", [xhr, s, e] );
		}
	},
    uploadHttpData: function( r, type ) {
        var data = !type;
        data = type == "xml" || data ? r.responseXML : r.responseText;
        // If the type is "script", eval it in global context
        if ( type == "script" )
            $.globalEval( data );
        // Get the JavaScript object, if JSON is used.
        if ( type == "json" )
            eval( "data = " + data );
        // evaluate scripts within html
        if ( type == "html" )
            $("<div>").html(data).evalScripts();
            //alert($('param', data).each(function(){alert($(this).attr('value'));}));
        return data;
    }
})