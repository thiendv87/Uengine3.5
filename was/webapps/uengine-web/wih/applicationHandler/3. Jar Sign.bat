rem Ű�� �����Ѵ�.
keytool -genkey -alias signedmetaworks -keystore uenginestore -keypass jinyoungj -dname "cn=uEngine.org" -storepass jinyoungj

rem jar ���Ͽ� ������ �Ѵ�.
jarsigner -keystore uenginestore -storepass jinyoungj -keypass jinyoungj -signedjar signedmetaworks.jar metaworks.jar signedmetaworks

rem ����Ű ������ �����.
rem keytool -export -keystore uenginestore -storepass jinyoungj -alias signedmetaworks -file signedmetaworks.cer