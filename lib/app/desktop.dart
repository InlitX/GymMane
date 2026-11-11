import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DesktopScope extends InheritedWidget {
  const DesktopScope({super.key, required this.wide, required super.child});

  final bool wide;

  static const minWidth = 1000.0;
  static const sidebarWidth = 252.0;
  static const readingWidth = 760.0;
  static const flowWidth = 1600.0;

  static bool wideFor(double width) => kIsWeb && width >= minWidth;

  static bool of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DesktopScope>()?.wide ?? false;

  @override
  bool updateShouldNotify(DesktopScope oldWidget) => oldWidget.wide != wide;
}

class FlowWide extends ParentDataWidget<CardFlowData> {
  const FlowWide({super.key, required super.child});

  @override
  void applyParentData(RenderObject renderObject) {
    final data = renderObject.parentData as CardFlowData;
    if (data.wide) return;
    data.wide = true;
    renderObject.parent?.markNeedsLayout();
  }

  @override
  Type get debugTypicalAncestorWidgetClass => CardFlow;
}

class FlowSlot extends ParentDataWidget<CardFlowData> {
  const FlowSlot({super.key, this.column, this.lift = 0, this.span = 1, this.stretch = false, required super.child});

  final int? column;
  final double lift;
  final int span;
  final bool stretch;

  @override
  void applyParentData(RenderObject renderObject) {
    final data = renderObject.parentData as CardFlowData;
    if (data.lift == lift && data.column == column && data.span == span && data.stretch == stretch) return;
    data.stretch = stretch;
    data.lift = lift;
    data.column = column;
    data.span = span;
    renderObject.parent?.markNeedsLayout();
  }

  @override
  Type get debugTypicalAncestorWidgetClass => CardFlow;
}

class CardFlow extends MultiChildRenderObjectWidget {
  const CardFlow({super.key, required super.children, this.minColumn = 360, this.maxColumns = 3, this.gap = 22});

  final double minColumn;
  final int maxColumns;
  final double gap;

  static int columnsFor(double width, {double minColumn = 360, int maxColumns = 3, double gap = 22}) =>
      math.max(1, math.min(maxColumns, ((width + gap) / (minColumn + gap)).floor()));

  @override
  RenderObject createRenderObject(BuildContext context) => RenderCardFlow(
      minColumn: minColumn, maxColumns: maxColumns, gap: gap, rtl: Directionality.of(context) == TextDirection.rtl);

  @override
  void updateRenderObject(BuildContext context, RenderCardFlow renderObject) {
    renderObject
      ..minColumn = minColumn
      ..maxColumns = maxColumns
      ..gap = gap
      ..rtl = Directionality.of(context) == TextDirection.rtl;
  }
}

class CardFlowData extends ContainerBoxParentData<RenderBox> {
  bool wide = false;
  double lift = 0;
  int? column;
  int span = 1;
  bool stretch = false;
}

class RenderCardFlow extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, CardFlowData>, RenderBoxContainerDefaultsMixin<RenderBox, CardFlowData> {
  RenderCardFlow({required double minColumn, required int maxColumns, required double gap, required bool rtl})
      : _minColumn = minColumn,
        _maxColumns = maxColumns,
        _gap = gap,
        _rtl = rtl;

  bool _rtl;

  set rtl(bool v) {
    if (v == _rtl) return;
    _rtl = v;
    markNeedsLayout();
  }

  double _minColumn;
  int _maxColumns;
  double _gap;

  set minColumn(double v) {
    if (v == _minColumn) return;
    _minColumn = v;
    markNeedsLayout();
  }

  set maxColumns(int v) {
    if (v == _maxColumns) return;
    _maxColumns = v;
    markNeedsLayout();
  }

  set gap(double v) {
    if (v == _gap) return;
    _gap = v;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! CardFlowData) child.parentData = CardFlowData();
  }

  int _columnsFor(double width) =>
      CardFlow.columnsFor(width, minColumn: _minColumn, maxColumns: _maxColumns, gap: _gap);

  @override
  void performLayout() {
    final width = constraints.maxWidth;
    final n = _columnsFor(width);
    final colW = (width - _gap * (n - 1)) / n;
    final heights = List<double>.filled(n, 0);
    final order = <RenderBox>[];
    final spans = <RenderBox>[];
    final wides = <RenderBox>[];
    for (var c = firstChild; c != null; c = (c.parentData as CardFlowData).nextSibling) {
      final d = c.parentData as CardFlowData;
      if (n == 1) {
        order.add(c);
      } else if (d.wide || d.span >= n) {
        wides.add(c);
      } else if (d.span > 1) {
        spans.add(c);
      } else {
        order.add(c);
      }
    }
    order
      ..addAll(spans)
      ..addAll(wides);
    final last = List<RenderBox?>.filled(n, null);
    var evened = false;
    void even() {
      if (evened || n == 1) return;
      evened = true;
      final target = heights.reduce(math.max);
      for (var i = 0; i < n; i++) {
        final c = last[i];
        if (c == null) continue;
        final d = c.parentData as CardFlowData;
        final extra = target - heights[i];
        if (!d.stretch || extra < 0.5) continue;
        c.layout(BoxConstraints.tightFor(width: c.size.width, height: c.size.height + extra), parentUsesSize: true);
        heights[i] = target;
      }
    }
    for (final child in order) {
      final data = child.parentData as CardFlowData;
      if (data.wide || data.span > 1) even();
      if (n > 1 && data.span > 1 && data.span < n && !data.wide) {
        final k = data.span;
        final top = heights.sublist(0, k).reduce(math.max);
        final w = colW * k + _gap * (k - 1);
        child.layout(BoxConstraints.tightFor(width: w), parentUsesSize: true);
        data.offset = Offset(_rtl ? width - w : 0, top);
        for (var i = 0; i < k; i++) {
          heights[i] = top + child.size.height + (child.size.height > 0 ? _gap : 0);
        }
      } else if (data.wide || data.span >= n || n == 1) {
        final top = heights.reduce(math.max);
        child.layout(BoxConstraints.tightFor(width: width), parentUsesSize: true);
        data.offset = Offset(0, top);
        final next = top + child.size.height + (child.size.height > 0 ? _gap : 0);
        for (var i = 0; i < n; i++) {
          heights[i] = next;
        }
      } else {
        var col = 0;
        for (var i = 1; i < n; i++) {
          if (heights[i] < heights[col] - 0.5) col = i;
        }
        final want = data.column;
        if (n >= 3 && want != null && want < n) col = want;
        child.layout(BoxConstraints.tightFor(width: colW), parentUsesSize: true);
        final x = _rtl ? width - colW - col * (colW + _gap) : col * (colW + _gap);
        final up = heights[col] == 0 && n > 1 ? data.lift : 0.0;
        data.offset = Offset(x, heights[col] - up);
        if (child.size.height > 0) heights[col] += child.size.height - up + _gap;
        last[col] = child;
      }
    }
    even();
    final tallest = heights.reduce(math.max);
    size = constraints.constrain(Size(width, math.max(0, tallest - _gap)));
  }

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}
