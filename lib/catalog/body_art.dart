import 'body_svg.dart';
import 'body_svg_female.dart';

class BodyArt {
  const BodyArt(this.id, this.base, this.lite, this.fills, this.hits, {this.head = const [], this.headInner = const [], this.headCut = 0});

  final String id;
  final List<String> base;
  final List<String> lite;
  final Map<String, List<String>> fills;
  final Map<String, List<String>> hits;
  final List<String> head;
  final List<String> headInner;
  final double headCut;
}

const maleBody = BodyArt('m', bodyBaseMain, bodyBaseLite, muscleFills, muscleHits);
const femaleBody =
    BodyArt('f', femaleBaseMain, femaleBaseLite, femaleFills, femaleHits, head: femaleHead, headInner: femaleHeadInner, headCut: femaleHeadCut);

BodyArt bodyArtFor(String sex) => sex == 'female' ? femaleBody : maleBody;
