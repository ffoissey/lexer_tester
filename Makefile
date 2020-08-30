# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ffoissey <ffoissey@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/11 17:23:00 by ffoissey          #+#    #+#              #
#    Updated: 2020/08/30 16:47:56 by ffoissey         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
################################                ################################
################################ MAIN VARIABLES ################################
################################                ################################
################################################################################

# Name
NAME = lexer_tester

# Compiler
CC = clang

# Lib
PATH_LIBFT = libft/
LIBFT = $(PATH_LIBFT)libft.a

# Compiler Flags
CFLAGS += -Wall
CFLAGS += -Wextra

# Compiler Debug Flags
ifeq ($(d), 0)
	CFLAGS += -g3
else ifeq ($(d), 1)
	CFLAGS += -g3
	CFLAGS += -fsanitize=address,undefined
else ifeq ($(d), 2)
	CFLAGS += -g3
	CFLAGS += -fsanitize=address,undefined
	CFLAGS += -Wpadded
else ifeq ($(d), 3)
	CFLAGS += -g3
	CFLAGS += -fsanitize=address,undefined
	CFLAGS += -Wpadded
	CFLAGS += -pedantic
else ifeq ($(d), 4)
	CFLAGS += -g3
	CFLAGS += -fsanitize=address,undefined
	CFLAGS += -Wpadded
	CFLAGS += -pedantic
	CFLAGS += -Weverything
endif
ifneq ($(err), no)
	CFLAGS += -Werror
endif

# Debug Dir
DSYM += $(NAME).dSYM
DSYM += $(DBNAME).dSYM

################################################################################
################################                ################################
################################   PRINT VAR    ################################
################################                ################################
################################################################################

# Reset
NC = \033[0m

# Regular Colors
BLACK = \033[0;30m
RED = \033[0;31m
GREEN = \033[32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
PURPLE = \033[0;35m
CYAN = \033[0;36m
WHITE = \033[0;37m

# One Line Output
ONELINE =\e[1A\r

################################################################################
#################################               ################################
#################################    INCLUDES   ################################
#################################               ################################
################################################################################

INCLUDES_LIBFT = libft/includes/
INCLUDES_FT_SELECT = includes/

I_INCLUDES += -I $(INCLUDES_LIBFT)
I_INCLUDES += -I $(INCLUDES_FT_SELECT)

################################################################################
#################################               ################################
#################################    HEADERS    ################################
#################################               ################################
################################################################################

vpath %.h $(INCLUDES_LIBFT)
vpath %.h $(INCLUDES_FT_SELECT)

# libft
HEADER += libft.h

# ft_select
HEADER += tester.h

################################################################################
#################################               ################################
#################################  PATH SOURCES ################################
#################################               ################################
################################################################################

PATH_SRCS += sources/

################################################################################
#################################               ################################
#################################    SOURCES    ################################
#################################               ################################
################################################################################

SRCS += process.c
SRCS += grammar.c
SRCS += print.c
SRCS += __tester.c

################# ATTRIBUTION

vpath %.c $(PATH_SRCS)

################################################################################
#################################               ################################
#################################     OBJS      ################################
#################################               ################################
################################################################################

PATH_OBJS = objs/
OBJS = $(patsubst %.c, $(PATH_OBJS)%.o, $(SRCS))

################################################################################
#################################               ################################
#################################     RULES     ################################
#################################               ################################
################################################################################

#---------------------------------- STANDARD ----------------------------------#

all: $(NAME)

$(NAME): $(LIBFT) $(PATH_OBJS) $(OBJS)
	$(CC) $(CFLAGS) $(I_INCLUDES) $(OBJS) $(LIBFT) -ltermcap -o $@
	printf "$(GREEN)$@ is ready.\n$(NC)"

$(OBJS): $(PATH_OBJS)%.o: %.c $(HEADER) Makefile
	$(CC) $(CFLAGS) $(I_INCLUDES) -c $< -o $@
	printf "$(ONELINE)$(CYAN)Compiling $<"
	printf "                                                            \n$(NC)"

$(PATH_OBJS):
	mkdir $@

$(LIBFT): FORCE 
	$(MAKE) -C $(PATH_LIBFT)

#--------------------------------- Basic Rules --------------------------------#

clean:
	$(RM) $(OBJS)
	$(RM) -R $(PATH_OBJS)
	$(RM) -R $(DSYM)
	$(MAKE) -C $(PATH_LIBFT) clean
	printf "$(RED)Objs from $(NAME) removed\n$(NC)"

fclean: clean
	$(RM) $(NAME)
	$(MAKE) -C $(PATH_LIBFT) fclean
	printf "$(RED)$(NAME) removed\n$(NC)"

re: fclean
	$(MAKE)

FORCE:

#----------------------------------- Special ----------------------------------#

.PHONY: clean fclean re all FORCE
.SILENT:
