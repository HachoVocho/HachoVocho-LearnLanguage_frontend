import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
}

class Uninitialized extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FailErrorMessageState extends BaseState {
  String errorMessage;

  FailErrorMessageState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class Authenticated extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Unauthenticated extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateInitial extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateLoading extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostsLoading extends BaseState {
  final bool? isFirstFetch;
  final List oldPosts;
  const PostsLoading(this.oldPosts,{this.isFirstFetch = false});
  @override
  // TODO: implement props
  List<Object?> get props => [isFirstFetch,oldPosts];
}

class ReviewsDataLoading extends BaseState {
  final bool? isFirstFetch;
  final List oldData;
  const ReviewsDataLoading(this.oldData,{this.isFirstFetch = false});
  @override
  // TODO: implement props
  List<Object?> get props => [isFirstFetch,oldData];
}

class GroupCommitmentsLoading extends BaseState {
  final bool? isFirstFetch;
  final List oldGroupCommitments;
  const GroupCommitmentsLoading(this.oldGroupCommitments,{this.isFirstFetch = false});
  @override
  // TODO: implement props
  List<Object?> get props => [isFirstFetch,oldGroupCommitments];
}

class MyCommitmentsLoading extends BaseState {
  final bool? isFirstFetch;
  final List<dynamic>? myOldCommitments;
  const MyCommitmentsLoading(this.myOldCommitments,{this.isFirstFetch = false});
  @override
  // TODO: implement props
  List<Object?> get props => [isFirstFetch,myOldCommitments];
}

class PostsLoaded extends BaseState {
  final List? posts;
  const PostsLoaded(this.posts);
  @override
  // TODO: implement props
  List<Object?> get props => [posts];
}

class StateNoData extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateShowSearching extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateSearchResult<T> extends BaseState {
  T response;

  StateSearchResult(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class StateInternetError extends BaseState {
  String? errorMessage;

  StateInternetError({this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class StateError400 extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateAuthError extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateErrorServer extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StateOnSuccess<T> extends BaseState {
  T items;
  T price;

  StateOnSuccess(this.items, this.price);

  @override
  // TODO: implement props
  List<Object?> get props => [items, price];
}

class StateOnSuccess1<T> extends BaseState {
  T items;
  T price;

  StateOnSuccess1(this.items, this.price);
  @override
  // TODO: implement props
  List<Object?> get props => [items, price];
}

class ValidationError extends BaseState {
  String errorMessage;

  ValidationError(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class StateErrorGeneral extends BaseState {
  String errorMessage;

  StateErrorGeneral(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class StateLogout extends BaseState {
  const StateLogout();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RedirectToWebState extends BaseState {
  // TODO: implement stringify
  @override
  bool? get stringify => null;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StatePaginationSuccess extends BaseState implements Equatable {
  List data;
  bool isEndOfList;
  //int index;
  //int limit;
  bool isServerError;
  bool isInternetError;
  int page;

  /*StatePaginationSuccess(this.data, this.isEndOfList, this.index, this.limit,
      {this.isServerError = false, this.isInternetError = false});*/

  StatePaginationSuccess(this.data, this.isEndOfList, this.page,
      {this.isServerError = false, this.isInternetError = false});

  StatePaginationSuccess copyWith({
    List? data,
    bool? isEndOfList,
    /*int offset,
    int limit,*/
    int? page,
    bool? isServerError,
    bool? isInternetError,
  }) =>
      StatePaginationSuccess(
        data ?? this.data,
        isEndOfList ?? this.isEndOfList,
        page ?? this.page,
        /*offset ?? this.index,
        limit ?? this.limit,*/
        isServerError: isServerError ?? this.isServerError,
        isInternetError: isInternetError ?? this.isInternetError,
      );

  @override
// TODO: implement props
  List<Object> get props => [data, isEndOfList, isServerError, isInternetError];

  @override
  // TODO: implement stringify
  bool? get stringify => null;
}

class StatePaginationInternetError<T> extends BaseState {
  T response;

  StatePaginationInternetError(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class StatePaginationServerError<T> extends BaseState {
  T response;

  StatePaginationServerError(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class StateOnResponseSuccess<T> extends BaseState {
  T response;

  StateOnResponseSuccess(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}