bin_targets=batt chrome temps cmos-setup-hints pbcopy pinentry reset-network \
	kill-evolution-sig-scripts \
	proctitlemon \

sbin_targets=average battd \
	mrtg-getinfo-fanspeed \
#	sysmond \

service_targets=sysmond \

all:

install: $(addprefix /usr/local/bin/,$(bin_targets)) \
	$(addprefix /usr/local/sbin/,$(sbin_targets)) \
	$(addsuffix /run,$(addprefix /usr/local/service/,$(service_targets))) \

/usr/local/bin/%: %
	case "`head -1 "$<"`" in *perl*) perl -cw "$<";; *) true; esac
	install -o 0 -g 0 -m 755 $< $@

/usr/local/sbin/%: %
	case "`head -1 "$<"`" in *perl*) perl -cw "$<";; *) true; esac
	install -o 0 -g 0 -m 755 $< $@

/usr/local/service/%/run: %
	mkdir -p $(dir $@)
	case "`head -1 "$<"`" in *perl*) perl -cw "$<";; *) true; esac
	install -o 0 -g 0 -m 755 $< $@
