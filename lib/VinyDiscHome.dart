import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vinyldiskheader/album.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class VinyDiscHome extends StatelessWidget {
  const VinyDiscHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: _MyVinylDiscHeader(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  currentAlbum.description,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

const _maxHeaderExtent = 350.0;
const _minHeaderExtent = 100.0;

const _maxImageSize = 160.0;
const _minImageSize = 60.0;

const _leftMarginDisc = 150.0;

const _maxTitleSize = 25.0;
const _maxSubTitleSize = 18.0;

const _minTitleSize = 16.0;
const _minSubTitleSize = 12.0;

class _MyVinylDiscHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    final size = MediaQuery.of(context).size;
    final currentImageSize =
        (_maxImageSize * (1 - percent)).clamp(_minImageSize, _maxImageSize);
    final tilteSize =
        (_maxTitleSize * (1 - percent)).clamp(_minTitleSize, _maxTitleSize);
    final subtitleSize = (_maxSubTitleSize * (1 - percent))
        .clamp(_minSubTitleSize, _maxSubTitleSize);
    final maxMargin = size.width / 4;
    final textMovement = 50.0;
    final leftTextMargin = maxMargin + (textMovement*percent);
    return Container(
      color: Color(0xFFECECEA),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 60.0,
            left: leftTextMargin,
            height: _maxImageSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  currentAlbum.artist,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: tilteSize,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  currentAlbum.album,
                  style: TextStyle(
                    fontSize: subtitleSize,
                    letterSpacing: -0.5,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            left:
                (_leftMarginDisc * (1 - percent)).clamp(33.0, _leftMarginDisc),
            height: currentImageSize,
            child: Transform.rotate(
              angle: vector.radians(360 * percent),
              child: Image.asset(currentAlbum.imageDisc),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 35.0,
            height: currentImageSize,
            child: Image.asset(currentAlbum.imageAlbum),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
