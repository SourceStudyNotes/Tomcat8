<%@ page 	contentType="text/html; charset=GBK" %>
<%@ page 	import="javax.servlet.ServletInputStream" %>
<%@ page 	import="java.util.*" %>
<%@ page 	import="java.io.*" %>

<html>
<head>
<title>get method</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body>
<%
	request.setCharacterEncoding("GBK");

		//掕?name,value?検丆埲媦暥審?巙埵
		String name = null;
		String value = null;
		//ArrayList value = null;//峏夵懚?value揑?徾丅
		boolean fileFlag = false;
		// TMP_DIR
		String TMP_DIR = "C:\\";
		File tmpFile = null;
		//file name
		String fName = null;
		
        FileOutputStream baos = null;
        BufferedOutputStream bos = null;
		//掕?懚曻嶲悢揑Hashtable丅
		Hashtable paramHt = new Hashtable();
int BUFSIZE = 1024 * 8;		
		int rtnPos = 0;
		byte[] buffs = new byte[ BUFSIZE * 8 ];
		//庢摼?巒晞丅
		String contentType = request.getContentType();
		int index = contentType.indexOf( "boundary=" );
String boundary = "--" + contentType.substring( index + 9 );
       		String endBoundary = boundary + "--";
		//庢摼棳丅
		ServletInputStream sis = request.getInputStream();
		//?庢1峴悢悩
		while( (rtnPos = sis.readLine( buffs, 0, buffs.length )) != -1 ){
			String strBuff = new String( buffs, 0, rtnPos );
			//敾抐庢摼揑悢悩
			//1. 擛壥惀?巒晞
			if( strBuff.startsWith( boundary ) ){
           			//擛壥name懚嵼
				if ( name != null && name.trim().length() > 0 ){
                  			//擛壥暥審?巙埵?true
					if (fileFlag ){
//?峴暥審懚?憖嶌丅
                        bos.flush();
                        baos.close();
                        bos.close();
                        baos = null;
           bos = null; 
}else{
                  			//擛壥暥審?巙埵?flase
                         		//?峴嶲悢?掕憖嶌丅
						Object obj = paramHt.get(name);
						ArrayList al = null;
if ( obj == null ){										al = new ArrayList();
}else{
	al = (ArrayList)obj;	
}
al.add(value);
paramHt.put(name, al);
}
				}
    				//廳怴弶巒壔name,value埲媦暥審?巙埵
    				name = new String();
				value = new String();
				fileFlag = false;
//?庢1峴悢悩丅
rtnPos = sis.readLine( buffs, 0, buffs.length );
if (rtnPos != -1 ){
strBuff = new String( buffs, 0, rtnPos );
           				//擛壥帤晞拞曪娷"Content-Disposition: form-data;"丆?庢name
					if (strBuff.toLowerCase().startsWith( "content-disposition: form-data; " )){
                					int nIndex = strBuff.toLowerCase().indexOf( "name=\"" );
                					int nLastIndex = strBuff.toLowerCase().indexOf( "\"", nIndex + 6 );
            name = strBuff.substring( nIndex + 6, nLastIndex );
}
           				//擛壥帤晞拞曪娷"filename"丆?掕暥審?巙埵?true丆?庢暥審柤帤丅
					int fIndex = strBuff.toLowerCase().indexOf( "filename=\"" );
					if (fIndex != -1 ){
	fileFlag = true;
						int fLastIndex = strBuff.toLowerCase().indexOf( "\"", fIndex + 10 );
         fName = strBuff.substring( fIndex + 10 , fLastIndex );
	        					fIndex = fName.lastIndexOf( "\\" );
        						if( fIndex == -1 ){
            						fIndex = fName.lastIndexOf( "/" );
            						if( fIndex != -1 ){
								fName = fName.substring( fIndex + 1 );
            						}
        							}else{
	fName = fName.substring( fIndex + 1 );
}
if (fName == null || fName.trim().length() == 0){
	fileFlag = false;
	sis.readLine( buffs, 0, buffs.length );
sis.readLine( buffs, 0, buffs.length );
sis.readLine( buffs, 0, buffs.length );
continue;
}
}
sis.readLine( buffs, 0, buffs.length );
sis.readLine( buffs, 0, buffs.length );
				}
//2. 擛壥惀?懇晞
}else if( strBuff.startsWith( endBoundary ) ){
           			//擛壥name懚嵼
				if ( name != null && name.trim().length() > 0 ){
                  			//擛壥暥審?巙埵?true
					if (fileFlag ){
//?峴暥審懚?憖嶌丅
                        bos.flush();
                        baos.close();
                        bos.close();
                        baos = null;
           bos = null; 
}else{
                  			//擛壥暥審?巙埵?flase
                         		//?峴嶲悢?掕憖嶌丅
						Object obj = paramHt.get(name);
						ArrayList al = null;
if ( obj == null ){										al = new ArrayList();
}else{
	al = (ArrayList)obj;	
}
al.add(value);

paramHt.put(name, al);
}
				}
//4. 擛壥晄惀1丆2揑忣檝丅
}else{
           		//value憡壛丅
				if (fileFlag ){
                if ( baos == null && bos == null ) {
                       tmpFile = new File( TMP_DIR + fName );
                       baos = new FileOutputStream( tmpFile );
                        bos = new BufferedOutputStream( baos );
                }
					bos.write( buffs, 0, rtnPos );
baos.flush();
}else{
	value = value + strBuff;
}
			}
		}
%>
</body>
</html>
