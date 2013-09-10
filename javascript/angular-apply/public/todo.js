function TodoCtrl($scope, $http) {
  $scope.todos = [
                    { text:'learn apply angular', done:false },
                    { text:'what is $apply?', done:false }
                 ];

  angular.element("#refreshPageDigest").click(function(e){
    $scope.$digest();
  });
 
  angular.element("#clickMeApply").click(function(e){
    $scope.$apply(function(){
      $scope.todos.push( { text:'Angular click with apply', done: false } )
    })
  });

  angular.element("#clickMeNoApply").click(function(e){
    $scope.todos.push( { text:'Angular click without apply', done: false } )
  });

  angular.element("#ajaxWithjQueryApply").click(function(e){
    $.get("/ajax", {}, function(data) {
      $scope.$apply(function(e){
        $scope.todos.push( { text: data, done: false } )
      })
    })
  });

  angular.element("#ajaxWithjQueryNoApply").click(function(e){
    $.get("/ajax", {}, function(data) {
      $scope.todos.push( { text: data, done: false } )
    })
  });

}