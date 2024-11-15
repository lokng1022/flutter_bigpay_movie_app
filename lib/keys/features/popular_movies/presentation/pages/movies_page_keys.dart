import 'package:flutter/material.dart';

/// Movie page scaffold key.
const Key moviePageScaffoldKey = Key('moviePageScaffoldKey');

/// Movie page appbar key.
const Key moviePageAppbarKey = Key('moviePageScaffold_appbarKey');

/// Movie page grid view list key.
const Key moviePageSliverGridViewListKey =
    Key('moviePageScaffold_sliverGridViewListKey');

/// Movie page grid view list item key.
Key moviePageSliverGridViewListItemKey(int index) =>
    Key('${index}_moviePageScaffold_sliverGridViewListItemKey');

/// Movie page error dialog key.
const Key moviePageAlertDialogKey = Key('moviePageScaffold_errorDialogKey');
