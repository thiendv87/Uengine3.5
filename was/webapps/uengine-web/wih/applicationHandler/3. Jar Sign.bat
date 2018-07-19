rem 키를 생성한다.
keytool -genkey -alias signedmetaworks -keystore uenginestore -keypass jinyoungj -dname "cn=uEngine.org" -storepass jinyoungj

rem jar 파일에 서명을 한다.
jarsigner -keystore uenginestore -storepass jinyoungj -keypass jinyoungj -signedjar signedmetaworks.jar metaworks.jar signedmetaworks

rem 공개키 증명서를 만든다.
rem keytool -export -keystore uenginestore -storepass jinyoungj -alias signedmetaworks -file signedmetaworks.cer