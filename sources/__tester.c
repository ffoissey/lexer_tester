#include "tester.h"

t_list	*lexer(t_vector *input)
{
	t_list	*list = NULL;

	(void)input;
	return (list);
}



int		main(void)
{
	tester("1+9+2*7/4", "WORD=1;+;WORD=9;+;WORD=2;*;WORD=7;/;WORD=4");
	tester("%7+84", "%;WORD=7;+;WORD=84");
	return (EXIT_SUCCESS);
}
