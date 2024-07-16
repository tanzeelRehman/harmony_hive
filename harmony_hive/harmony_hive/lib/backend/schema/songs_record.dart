import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SongsRecord extends FirestoreRecord {
  SongsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "artist" field.
  String? _artist;
  String get artist => _artist ?? '';
  bool hasArtist() => _artist != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  bool hasDuration() => _duration != null;

  // "centerTitle" field.
  String? _centerTitle;
  String get centerTitle => _centerTitle ?? '';
  bool hasCenterTitle() => _centerTitle != null;

  // "leftTitle" field.
  String? _leftTitle;
  String get leftTitle => _leftTitle ?? '';
  bool hasLeftTitle() => _leftTitle != null;

  // "rightTitle" field.
  String? _rightTitle;
  String get rightTitle => _rightTitle ?? '';
  bool hasRightTitle() => _rightTitle != null;

  // "topTitle" field.
  String? _topTitle;
  String get topTitle => _topTitle ?? '';
  bool hasTopTitle() => _topTitle != null;

  // "bottomTitle" field.
  String? _bottomTitle;
  String get bottomTitle => _bottomTitle ?? '';
  bool hasBottomTitle() => _bottomTitle != null;

  // "centerUrl" field.
  String? _centerUrl;
  String get centerUrl => _centerUrl ?? '';
  bool hasCenterUrl() => _centerUrl != null;

  // "leftUrl" field.
  String? _leftUrl;
  String get leftUrl => _leftUrl ?? '';
  bool hasLeftUrl() => _leftUrl != null;

  // "rightUrl" field.
  String? _rightUrl;
  String get rightUrl => _rightUrl ?? '';
  bool hasRightUrl() => _rightUrl != null;

  // "topUrl" field.
  String? _topUrl;
  String get topUrl => _topUrl ?? '';
  bool hasTopUrl() => _topUrl != null;

  // "bottomUrl" field.
  String? _bottomUrl;
  String get bottomUrl => _bottomUrl ?? '';
  bool hasBottomUrl() => _bottomUrl != null;

  // "imageURL" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasimageUrl() => _imageUrl != null;

  // "isNewSong" field.
  bool? _isNewSong;
  bool get isNewSong => _isNewSong ?? false;
  bool hasisNewSong() => _isNewSong != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _artist = snapshotData['artist'] as String?;
    _duration = snapshotData['duration'] as String?;
    _centerTitle = snapshotData['centerTitle'] as String?;
    _leftTitle = snapshotData['leftTitle'] as String?;
    _rightTitle = snapshotData['rightTitle'] as String?;
    _topTitle = snapshotData['topTitle'] as String?;
    _bottomTitle = snapshotData['bottomTitle'] as String?;
    _centerUrl = snapshotData['centerUrl'] as String?;
    _leftUrl = snapshotData['leftUrl'] as String?;
    _rightUrl = snapshotData['rightUrl'] as String?;
    _topUrl = snapshotData['topUrl'] as String?;
    _bottomUrl = snapshotData['bottomUrl'] as String?;
    _imageUrl = snapshotData['imageUrl'] as String?;
    _isNewSong = snapshotData['isNewSong'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Songs');

  static Stream<SongsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SongsRecord.fromSnapshot(s));

  static Future<SongsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SongsRecord.fromSnapshot(s));

  static SongsRecord fromSnapshot(DocumentSnapshot snapshot) => SongsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SongsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SongsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SongsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SongsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSongsRecordData({
  String? title,
  String? artist,
  String? duration,
  String? centerTitle,
  String? leftTitle,
  String? rightTitle,
  String? topTitle,
  String? bottomTitle,
  String? centerUrl,
  String? leftUrl,
  String? rightUrl,
  String? topUrl,
  String? bottomUrl,
  String? imageUrl,
  bool? isNewSong,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'artist': artist,
      'duration': duration,
      'centerTitle': centerTitle,
      'leftTitle': leftTitle,
      'rightTitle': rightTitle,
      'topTitle': topTitle,
      'bottomTitle': bottomTitle,
      'centerUrl': centerUrl,
      'leftUrl': leftUrl,
      'rightUrl': rightUrl,
      'topUrl': topUrl,
      'bottomUrl': bottomUrl,
      'imageUrl': imageUrl,
      'isNewSong': isNewSong,
    }.withoutNulls,
  );

  return firestoreData;
}

class SongsRecordDocumentEquality implements Equality<SongsRecord> {
  const SongsRecordDocumentEquality();

  @override
  bool equals(SongsRecord? e1, SongsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.artist == e2?.artist &&
        e1?.duration == e2?.duration &&
        e1?.centerTitle == e2?.centerTitle &&
        e1?.leftTitle == e2?.leftTitle &&
        e1?.rightTitle == e2?.rightTitle &&
        e1?.topTitle == e2?.topTitle &&
        e1?.bottomTitle == e2?.bottomTitle &&
        e1?.centerUrl == e2?.centerUrl &&
        e1?.leftUrl == e2?.leftUrl &&
        e1?.rightUrl == e2?.rightUrl &&
        e1?.topUrl == e2?.topUrl &&
        e1?.bottomUrl == e2?.bottomUrl &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.isNewSong == e2?.isNewSong;
  }

  @override
  int hash(SongsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.artist,
        e?.duration,
        e?.centerTitle,
        e?.leftTitle,
        e?.rightTitle,
        e?.topTitle,
        e?.bottomTitle,
        e?.centerUrl,
        e?.leftUrl,
        e?.rightUrl,
        e?.topUrl,
        e?.bottomUrl,
        e?.imageUrl,
        e?.isNewSong,
      ]);

  @override
  bool isValidKey(Object? o) => o is SongsRecord;
}
