rem Ű�� �����Ѵ�.
keytool -genkey -alias SignedDocumentInvoker -keystore uenginestore -keypass jinyoungj -dname "cn=uEngine.org" -storepass jinyoungj

rem jar ���Ͽ� ������ �Ѵ�.
jarsigner -keystore uenginestore -storepass jinyoungj -keypass jinyoungj -signedjar SignedDocumentInvoker.jar DocumentInvoker.jar SignedDocumentInvoker

rem ����Ű ������ �����.
rem keytool -export -keystore uenginestore -storepass jinyoungj -alias SignedDocumentInvoker -file SignedDocumentInvoker.cer