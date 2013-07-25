
(require 'ert)
(ert-deftest plus_test ()
  (should (equal 3
		 (+ 1 2))))
(ert-run-tests-batch-and-exit)

