component {
	
/**
 * Case-sensitive function for removing duplicate entries in a list.
 * Based on dedupe by Raymond Camden
 * 
 * @param list 	 The list to be modified. (Required)
 * @return Returns a list. 
 * @author Jeff Howden (cflib@jeffhowden.com) 
 * @version 1, July 2, 2008 
 */
function ListDeleteDuplicates(list) {
  var i = 1;
  var delimiter = ',';
  var returnValue = '';
  if(ArrayLen(arguments) GTE 2)
    delimiter = arguments[2];
  list = ListToArray(list, delimiter);
  for(i = 1; i LTE ArrayLen(list); i = i + 1)
    if(NOT ListFind(returnValue, list[i], delimiter))
      returnValue = ListAppend(returnValue, list[i], delimiter);
  return returnValue;
}

}