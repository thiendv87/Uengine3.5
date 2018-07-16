<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>json object tag library test page</title>
</head>
<body>

<bpm:jsonObject var="list">
[
    "item1",
    "item2",
    "item3",
    "item4"
]
</bpm:jsonObject>

<h2>List 예제</h2>
<ul>
    <c:forEach var="item" items="${list}">
        <li>${item}</li>
    </c:forEach>
</ul>

<bpm:jsonObject var="person">
{
    name: "이름",
    address : "주소",
    phone: "폰번호",
    homepage: "http://www.uengine.org"
}
</bpm:jsonObject>

<h2>Map 예제</h2>
<ul>
    <c:forEach var="entry" items="${person}">
        <li>${entry.key} : ${entry.value}</li>
    </c:forEach>
</ul>
<p>person['homepage']도 가능 : ${person['homepage']}</p>


</body>
</html>