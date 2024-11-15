import 'package:flutter/material.dart';

/// Movie page scaffold key.
const Key moviePageScaffoldKey = Key('moviePageScaffoldKey');

/// Movie page appbar key.
const Key moviePageAppbarKey = Key('moviePage_appbarKey');

/// Movie page grid view list key.
const Key moviePageSliverGridViewListKey =
    Key('moviePage_sliverGridViewListKey');

/// Movie page grid view list item key.
Key moviePageSliverGridViewListItemKey(int index) =>
    Key('${index}_moviePage_sliverGridViewListItemKey');

/// Movie page loading indicator key.
const Key moviePageLoadingIndicatorKey = Key('moviePage_loadingIndicatorKey');
