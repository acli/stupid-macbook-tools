bin_targets=batt chrome temps cmos-setup-hints pbcopy pinentry reset-network \
	en fi fr yue-HK zh-HK zh-TW no-locale \
	brave-browser \
	ctime \
	evolution \
	fanspeed \
	firefox \
	gaim \
	gaim-status \
	is-at-home-p \
	kill-browsers \
	kill-evolution \
	kill-evolution-sig-scripts \
	pa-set-sink-port \
	proctitlemon \
	recover-ssh-agent \
	wdiffless \

sbin_targets=activate-darwin-swap \
	average \
	battd \
	lineinmon-xmod \
	mrtg-getinfo-fanspeed \
	ntpd \
	update-nightly \

service_targets=sysmond \

all:

install: $(addprefix /usr/local/bin/,$(bin_targets)) \
	$(addprefix /usr/local/sbin/,$(sbin_targets)) \
	$(addsuffix /run,$(addprefix /usr/local/service/,$(service_targets))) \

/usr/local/bin/%: %
	case "`head -1 "$<"`" in *perl*) perl -cw "$<";; /bin/sh|/bin/bash) bash -n "$<";; *) true; esac
	install -o 0 -g 0 -m 755 $< $@

/usr/local/sbin/%: %
	case "`head -1 "$<"`" in *perl*) perl -cw "$<";; /bin/sh|/bin/bash) bash -n "$<";; *) true; esac
	install -o 0 -g 0 -m 755 $< $@

/usr/local/service/%/run: %
	mkdir -p $(dir $@)
	case "`head -1 "$<"`" in *perl*) perl -cw "$<";; /bin/sh|/bin/bash) bash -n "$<";; *) true; esac
	install -o 0 -g 0 -m 755 $< $@
