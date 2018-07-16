/**
 * 입력값이 숫자인지를 확인한다
 * param : sVal 입력스트링
 * return : Boolean True이면 숫자값
 */
function isNumber(sVal)
{
  if(sVal.length < 1) {
    return false;
  }
  
  for(i=0; i<sVal.length; i++) {
    iBit = parseInt(sVal.substring(i,i+1));     //문자(Char)를 숫자로 변경
    if((iBit < 0) || (iBit > 9)) {
      return false;
    }
  }
  return true;
}

/**
 * 사업자 번호가 정확한지 확인한다.
 * param : iSaupNo 사업자번호
 * return : Boolean true이면 검증된 사업자번호
 */
function bizNOCheck(iSaupNo)
{
  if (!isNumber(iSaupNo))
  {
    alert("사업자 번호는 반드시 숫자로 구성되어야 합니다.");
    return false;
  } 
  else if (iSaupNo.length != 10)
  {
    alert("사업자 번호는 10자리 입니다.");
    return false;
  }
  var arr_saup = iSaupNo.split("");
  var wtArray = new Array(1,3,7,1,3,7,1,3,5);
  var iSaup_9 = 0;
  var iSum_saup = 0;
  var iCheck_digit = 0;

  //1~8자리까지 가중치를 곱하여 모두 더한다.
  for (i = 0; i < 8; i++)
  {
      iSum_saup +=  eval(arr_saup[i]) * eval(wtArray[i]);
  }

  iSum_saup = iSum_saup % 10;
  //9번째 자리 숫자에 5를 곱한다.
  iSaup_9 = eval(arr_saup[8]) * 5

  //5를 곱한 값을 10으로 나누어  몫과 나머지를 각각 1~8합계에 더한다.
  iSum_saup +=  Math.floor(iSaup_9 / 10) + iSaup_9 % 10;

  //결과 값을 10에서 뺀다.
  iCheck_digit = 10 - (iSum_saup % 10);

  //계산 값을 10으로 나눈 나머지를 구한다. (Check Digit)
  iCheck_digit = iCheck_digit % 10;

  if (iCheck_digit != arr_saup[9])
  {
    alert("사업자 번호가 정확하지 않습니다. 확인 후 다시 입력해주시기 바랍니다.");
    return false;
  }
  return true;
}


/**
 * 법인 번호가 정확한지 확인한다.
 * param : sRegNo 법인번호
 * return : Boolean true이면 검증된 법인번호
 */
function corporationNoCheck(sRegNo)
{
  if (!isNumber(sRegNo))
  {
    alert("법인 번호는 반드시 숫자로 구성되어야 합니다.");
    return false;
  }
  else if (sRegNo.length != 13)
  {
    alert("법인 번호는 13자리 입니다.");
    return false;
  }

  var arr_regno = sRegNo.split("");
  var arr_wt = new Array(1,2,1,2,1,2,1,2,1,2,1,2);
  var iSum_regno = 0;
  var iCheck_digit = 0;

  //1~12자리까지 가중치를 곱하여 모두 더한다.
  for (i = 0; i < 12; i++) {
      iSum_regno +=  eval(arr_regno[i]) * eval(arr_wt[i]);
  }

  //합계를 10으로 나눈 나머지를 10에서 뺀다.
  iCheck_digit = 10 - (iSum_regno % 10);

  //계산 값을 10으로 나눈 나머지를 구한다. (Check Digit)
  iCheck_digit = iCheck_digit % 10;

  if (iCheck_digit != arr_regno[12]) {
      alert("법인 번호가 정확하지 않습니다. 확인 후 다시 입력해주시기 바랍니다.");
      return false;
  }

  return true;
}
