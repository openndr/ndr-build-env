COVAPP ?= $(NAME)

SRCDIR := $(NBE_ROOT)/$S
LDFLAGS += --as-needed -ldl
CFLAGS += -O0
CFLAGS += -g

.PHONY: build
build: $(LIBLIST) $(OBJLIST) $(COVLIST) linktest gcovgen gcovcp

.PHONY: depset
depset: mkdir $(HDRS)

mkdir::
	@[ -d $(NBE_MK_OBJPATH) ] || mkdir -p $(NBE_MK_OBJPATH)
	@[ -d $(NBE_MK_OBJPATH)/$(DPDKCOVAPP) ] || mkdir -p $(NBE_MK_OBJPATH)/$(DPDKCOVAPP)
	@[ -d $(NBE_MK_COVPATH) ] || mkdir -p $(NBE_MK_COVPATH)
	@[ -d $(NBE_MK_COVPATH)/$(COVAPP) ] || mkdir -p $(NBE_MK_COVPATH)/$(COVAPP)
	@[ -d $(NBE_COVPATH) ] || mkdir -p $(NBE_COVPATH)

$(LIBLIST)::
	$(eval LIBLIST += $(addprefix -l,$@))

$(OBJLIST)::
	$(eval LNKLIST += $(wildcard $(NBE_MK_OBJPATH)/$@/*.o))
	$(eval COVLNKS += $(wildcard $(NBE_MK_OBJPATH)/$@/*.cov.o))

$(COVLIST)::
	$(eval LNKLIST += $(wildcard $(NBE_MK_OBJPATH)/$@/*.o))
	$(eval COVLNKS += $(wildcard $(NBE_MK_COVPATH)/$@/*.o))
	$(eval COVDIRS += $(shell cat $(NBE_MK_COVPATH)/$@/build.path))
	$(eval COVFILES += $(wildcard $(shell cat $(NBE_MK_COVPATH)/$@/source.path)/*.c))
	$(eval COVFILES += $(wildcard $(shell cat $(NBE_MK_COVPATH)/$@/source.path)/*.cc))
	@cp -f $(NBE_MK_COVPATH)/$@/*.gcno .

linktest::
	@gcc -o $(COVAPP)_cov $(COVLNKS) -L$(NBE_LIBPATH) $(LIBLIST) $(NBE_LIBS) $(CFLAGS) $(EXTRA_CFLAGS) -lgcov
	@gcc -o $(COVAPP).app $(LNKLIST) -L$(NBE_LIBPATH) $(NBE_LIBS) $(LIBLIST) $(CFLAGS) $(EXTRA_CFLAGS)

gcovgen::
	@cp -f $(COVAPP).app $(NBE_COVPATH)/$(COVAPP).app
	@./$(COVAPP)_cov $(TESTARGS) > $(COVAPP).result 2>&1
	@cp -f $(foreach COVDIR, $(COVDIRS), $(COVDIR)/*.gcda) .
	@cp -f $(COVAPP).result $(NBE_COVPATH)/$(COVAPP).result
	@gcov $(COVFILES) -o .

gcovcp::
	@cp -f $(foreach COVFILE, $(COVFILES), ./$(notdir $(COVFILE)).gcov) $(NBE_COVPATH)/$(COVAPP)
	@$(NBE_SCRIPTS)/nbs.recover.sh $(NBE_PATHLOG_RESTORE) $(NBE_COVPATH)/$(COVAPP)
