rem 키를 생성한다.
keytool -genkey -alias SignedDocumentInvoker -keystore uenginestore -keypass jinyoungj -dname "cn=uEngine.org" -storepass jinyoungj

rem jar 파일에 서명을 한다.
jarsigner -keystore uenginestore -storepass jinyoungj -keypass jinyoungj -signedjar SignedDocumentInvoker.jar DocumentInvoker.jar SignedDocumentInvoker

rem 공개키 증명서를 만든다.
rem keytool -export -keystore uenginestore -storepass jinyoungj -alias SignedDocumentInvoker -file SignedDocumentInvoker.cer