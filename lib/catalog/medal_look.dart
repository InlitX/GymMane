import 'package:flutter/widgets.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../state/fit_state.dart';

class MedalMetal {
  const MedalMetal(this.base, this.lip, this.plateTop, this.plateLow, this.ink);

  final int base;
  final int lip;
  final int plateTop;
  final int plateLow;
  final int ink;
}

const _bronze = MedalMetal(0xa96a38, 0xe3a878, 0xf1b585, 0xab6635, 0x40251a);
const _silver = MedalMetal(0xa3abb6, 0xe2e9f0, 0xf7fafd, 0xa9b4c1, 0x272e37);
const _gold = MedalMetal(0xc6982c, 0xf6d97b, 0xf8e296, 0xbf8f1c, 0x43300c);
const _diamond = MedalMetal(0xb2c9dc, 0xeaf5fd, 0xffffff, 0xc1d6e6, 0x1f3646);

const _ruby = 0xc02347;
const _sapphire = 0x2f63c4;
const _emerald = 0x1f9f74;

class MedalLook {
  const MedalLook(this.icon, this.metal, {this.round = false, this.gem});

  final IconData icon;
  final MedalMetal metal;
  final bool round;
  final int? gem;
}

MedalLook medalLook(AwardId id) => switch (id) {
      AwardId.firstStep => const MedalLook(PhosphorIconsFill.flag, _bronze),
      AwardId.firstWorkout => const MedalLook(PhosphorIconsFill.barbell, _bronze, round: true),
      AwardId.firstRoutine => const MedalLook(PhosphorIconsFill.calendarCheck, _bronze),
      AwardId.firstRecord => const MedalLook(PhosphorIconsFill.trendUp, _bronze, round: true),
      AwardId.streak3 => const MedalLook(PhosphorIconsFill.fire, _bronze),
      AwardId.tonne1 => const MedalLook(PhosphorIconsFill.scales, _bronze, round: true),
      AwardId.sets100 => const MedalLook(PhosphorIconsFill.repeat, _bronze),
      AwardId.streak7 => const MedalLook(PhosphorIconsFill.fire, _silver),
      AwardId.workouts10 => const MedalLook(PhosphorIconsFill.barbell, _silver, round: true),
      AwardId.hours10 => const MedalLook(PhosphorIconsFill.hourglass, _silver),
      AwardId.workouts50 => const MedalLook(PhosphorIconsFill.sneakerMove, _silver, round: true),
      AwardId.tonnes10 => const MedalLook(PhosphorIconsFill.scales, _silver),
      AwardId.sets1000 => const MedalLook(PhosphorIconsFill.repeat, _silver, round: true),
      AwardId.streak30 => const MedalLook(PhosphorIconsFill.fire, _gold),
      AwardId.hours50 => const MedalLook(PhosphorIconsFill.hourglass, _gold, round: true),
      AwardId.workouts100 => const MedalLook(PhosphorIconsFill.medal, _gold),
      AwardId.hours100 => const MedalLook(PhosphorIconsFill.clock, _gold, round: true),
      AwardId.streak100 => const MedalLook(PhosphorIconsFill.fire, _diamond, gem: _ruby),
      AwardId.tonnes100 => const MedalLook(PhosphorIconsFill.stack, _diamond, gem: _sapphire),
      AwardId.workouts365 =>
        const MedalLook(PhosphorIconsFill.trophy, _diamond, round: true, gem: _emerald),
    };
