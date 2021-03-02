import 'package:flutter/material.dart';
import 'package:flutter_study_demo1/StreamBuilder/stream_builder_demo.dart';
import 'package:flutter_study_demo1/absorbPointer/absorb_pointer_demo.dart';
import 'package:flutter_study_demo1/align/align_demo.dart';
import 'package:flutter_study_demo1/animatedBuilder/animated_builder_demo.dart';
import 'package:flutter_study_demo1/animatedContainer/animated_container_demo.dart';
import 'package:flutter_study_demo1/animatedList/animated_list_demo.dart';
import 'package:flutter_study_demo1/backDropFilter/back_drop_filter_demo.dart';
import 'package:flutter_study_demo1/clipRRect/clip_rrect_demo.dart';
import 'package:flutter_study_demo1/customPoint/custom_point_demo.dart';
import 'package:flutter_study_demo1/customScrollView/custom_scroll_view_demo.dart';
import 'package:flutter_study_demo1/expanded/expanded.dart';
import 'package:flutter_study_demo1/fadeInImage/fade_in_image_demo.dart';
import 'package:flutter_study_demo1/fadeTransition/fade_transition_demo.dart';
import 'package:flutter_study_demo1/floatingActionButton/floating_action_button_demo.dart';
import 'package:flutter_study_demo1/futureBuilder/future_builder_demo.dart';
import 'package:flutter_study_demo1/gridView/grid_view_demo.dart';
import 'package:flutter_study_demo1/inheritedModel/inherited_model_demo.dart';
import 'package:flutter_study_demo1/inheritedWidget/inherited_widget_demo.dart';
import 'package:flutter_study_demo1/inheritedWidget/inherited_widget_demo2.dart';
import 'package:flutter_study_demo1/layoutBuilder/layout_builder_demo.dart';
import 'package:flutter_study_demo1/opacity/opacity_demo.dart';
import 'package:flutter_study_demo1/positioned/positioned_demo.dart';
import 'package:flutter_study_demo1/safearea/safearea_demo.dart';
import 'package:flutter_study_demo1/sizedBox/sized_box_demo.dart';
import 'package:flutter_study_demo1/sliverAppBar/sliver_app_bar_demo.dart';
import 'package:flutter_study_demo1/sliverList/sliver_list_demo.dart';
import 'package:flutter_study_demo1/table/table_demo.dart';
import 'package:flutter_study_demo1/transform/transform_demo.dart';
import 'package:flutter_study_demo1/valueListenableBuilder/value_listenable_builder_demo.dart';
import 'package:flutter_study_demo1/wrap/wrap_demo.dart';
import 'package:flutter_study_demo1/pageView/page_view_demo.dart';
import 'animatedIcon/animated_icon_demo.dart';
import 'aspectRatio/aspect_ratio_demo.dart';
import 'limitedBox/limited_box_demo.dart';
import 'placeholder/placeholder_demo.dart';
import 'richText/rich_text_demo.dart';
import 'reorderableListView/reorderable_listview_demo.dart';
import 'animatedSwitcher/animated_switcher_demo.dart';
import 'animatedPositioned/animated_positioned_demo.dart';
import 'animatedPadding/animated_padding_demo.dart';
import 'indexedStack/indexed_stack_demo.dart';
import 'semantics/semantics_demo.dart';
import 'constrainedBox/constrained_box_demo.dart';
import 'animatedOpacity/animated_opacity_demo.dart';
import 'fractionallySizedBox/fractionally_sizedbox_demo.dart';
import 'draggable/draggable_demo.dart';
import 'selectableText/selectable_text_demo.dart';
import 'dataTable/data_table_demo.dart';
import 'slider/slider_demo.dart';
import 'animatedCrossFade/animated_cross_fade_demo.dart';
import 'draggableScrollableSheet/draggable_scrollable_sheet_demo.dart';
import 'colorFiltered/color_filtered_demo.dart';
import 'toggleButtons/toggle_buttons_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter study Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<List> _list = [
    ['SafeArea demo', SafeAreaDemo()],
    ['Expanded demo', MyStatelessWidget()],
    ['Wrap demo', WrapDemo()],
    ['AnimatedContainer demo', AnimatedContainerDemo()],
    ['Opacity demo', OpacityDemo()],
    ['Future demo', FutureBuilderDemo()],
    ['fadeTransition demo', FadeTransitionDemo()],
    ['FloatingActionButton demo', FloatingActionButtonDemo()],
    ['PageViewDemo', PageViewDemo()],
    ['TableDemo', TableDemo()],
    ['GridViewDemo', GridViewDemo()],
    ['SliverAppBarDemo', SliverAppBarDemo()],
    ['SliverListDemo', SliverListDemo()],
    ['CustomScrollViewDemo', CustomScrollViewDemo()],
    ['FadeInImageDemo', FadeInImageDemo()],
    ['StreamBuilderDemo', StreamBuilderDemo()],
    ['InheritedWidget', DataContainer()],
    ['InheritedWidget2', InheritedWidgetTestRoute()],
    ['InheritedModel', InheritedModelDemo()],
    ['ClipRRectDemo', ClipRRectDemo()],
    ['CustomPointDemo', CustomPointDemo()],
    ['LayoutBuilderDemo', LayoutBuilderDemo()],
    ['AbsorbPointerDemo', AbsorbPointerDemo()],
    ['TransfromDemo', TransfromDemo()],
    ['BackDropFilterDemo', BackDropFilterDemo()],
    ['AlignDemo', AlignDemo()],
    ['PositionedDemo', PositionedDemo()],
    ['AnimatedBuilderDemo', AnimatedBuilderDemo()],
    ['SizedBoxDemo', SizedBoxDemo()],
    ['ValueListenableBuilderDemo', ValueListenableBuilderDemo()],
    ['DraggableDemo', DraggableDemo()],
    ['AnimatedListDemo', AnimatedListDemo()],
    ['AnimatedIconDemo', AnimatedIconDemo()],
    ['AspectRatioDe', AspectRatioDemo()],
    ['LimitedBoxDemo', LimitedBoxDemo()],
    ['PlaceholderDemo', PlaceholderDemo()],
    ['RichTextDemo', RichTextDemo()],
    ['ReorderableListViewDemo', ReorderableListViewDemo()],
    ['AnimatedSwitcherDemo', AnimatedSwitcherDemo()],
    ['AnimatedPositionedDemo', AnimatedPositionedDemo()],
    ['AnimatedPaddingDemo', AnimatedPaddingDemo()],
    ['IndexedStackDemo', IndexedStackDemo()],
    ['SemanticsDemo', SemanticsDemo()],
    ['ContrainedBoxDemo', ContrainedBoxDemo()],
    ['AnimatedOpacityDemo', AnimatedOpacityDemo()],
    ['FractionallySizedBoxDemo', FractionallySizedBoxDemo()],
    ['SelectableTextDemo', SelectableTextDemo()],
    ['DataTableDemo', DataTableDemo()],
    ['SliderDemo', SliderDemo()],
    ['AnimatedCrossFadeDemo', AnimatedCrossFadeDemo()],
    ['DraggableScrollableSheetDemo', DraggableScrollableSheetDemo()],
    ['ColorFilteredDemo', ColorFilteredDemo()],
    ['ToggleButtonsDemo', ToggleButtonsDemo()],
  ];
  @override
  Widget build(BuildContext context) {
    var gridView = GridView.extent(
      maxCrossAxisExtent: 200.0,
      childAspectRatio: 4.0,
      children: _list
          .map(
            (n) => RaisedButton(
              child: Text(
                n[0],
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return n[1];
                }));
              },
            ),
          )
          .toList(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: gridView,
    );
  }
}
