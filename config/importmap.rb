# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
pin "stripe" # @17.5.0
pin "#util.inspect.js" # @2.1.0
pin "call-bind" # @1.0.8
pin "call-bind-apply-helpers" # @1.0.1
pin "call-bind-apply-helpers/applyBind", to: "call-bind-apply-helpers--applyBind.js" # @1.0.1
pin "call-bind-apply-helpers/functionApply", to: "call-bind-apply-helpers--functionApply.js" # @1.0.1
pin "call-bind-apply-helpers/functionCall", to: "call-bind-apply-helpers--functionCall.js" # @1.0.1
pin "call-bound" # @1.0.2
pin "define-data-property" # @1.1.4
pin "dunder-proto/get", to: "dunder-proto--get.js" # @1.0.0
pin "es-define-property" # @1.0.1
pin "es-errors" # @1.3.0
pin "es-errors/eval", to: "es-errors--eval.js" # @1.3.0
pin "es-errors/range", to: "es-errors--range.js" # @1.3.0
pin "es-errors/ref", to: "es-errors--ref.js" # @1.3.0
pin "es-errors/syntax", to: "es-errors--syntax.js" # @1.3.0
pin "es-errors/type", to: "es-errors--type.js" # @1.3.0
pin "es-errors/uri", to: "es-errors--uri.js" # @1.3.0
pin "es-object-atoms" # @1.0.0
pin "function-bind" # @1.1.2
pin "get-intrinsic" # @1.2.7
pin "get-proto" # @1.0.1
pin "get-proto/Object.getPrototypeOf", to: "get-proto--Object.getPrototypeOf.js" # @1.0.1
pin "get-proto/Reflect.getPrototypeOf", to: "get-proto--Reflect.getPrototypeOf.js" # @1.0.1
pin "gopd" # @1.2.0
pin "has-property-descriptors" # @1.0.2
pin "has-symbols" # @1.1.0
pin "hasown" # @2.0.2
pin "math-intrinsics/abs", to: "math-intrinsics--abs.js" # @1.1.0
pin "math-intrinsics/floor", to: "math-intrinsics--floor.js" # @1.1.0
pin "math-intrinsics/max", to: "math-intrinsics--max.js" # @1.1.0
pin "math-intrinsics/min", to: "math-intrinsics--min.js" # @1.1.0
pin "math-intrinsics/pow", to: "math-intrinsics--pow.js" # @1.1.0
pin "math-intrinsics/round", to: "math-intrinsics--round.js" # @1.1.0
pin "math-intrinsics/sign", to: "math-intrinsics--sign.js" # @1.1.0
pin "object-inspect" # @1.13.3
pin "qs" # @6.13.1
pin "set-function-length" # @1.2.2
pin "side-channel" # @1.1.0
pin "side-channel-list" # @1.0.0
pin "side-channel-map" # @1.0.1
pin "side-channel-weakmap" # @1.0.2
