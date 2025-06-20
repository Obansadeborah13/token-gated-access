;; --------------------------------------------
;; SIP-010 Fungible Token Trait Definition
;; --------------------------------------------
(define-trait ft-trait
  (
    (transfer (uint principal principal (optional (buff 34))) (response bool uint))
    (get-balance (principal) (response uint uint))
    (get-total-supply () (response uint uint))
    (get-name () (response (string-ascii 32) uint))
    (get-symbol () (response (string-ascii 32) uint))
    (get-decimals () (response uint uint))
  )
)

;; --------------------------------------------
;; Configuration Constants
;; --------------------------------------------
(define-constant token-contract "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-access.my-token")
(define-constant required-balance u100)
(define-constant admin 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

;; --------------------------------------------
;; Access Log Map
;; --------------------------------------------
(define-map access-log
  {user: principal}
  {
    block: uint,
    allowed: bool
  }
)

;; --------------------------------------------
;; Read-only: Check if user has access
;; --------------------------------------------
(define-read-only (has-access (user principal))
    (ok (is-eq user admin))
)

;; --------------------------------------------
;; Public: Attempt to access content
;; --------------------------------------------
(define-public (access-content)
  (let ((user tx-sender))
    (let ((has-permission (unwrap-panic (has-access user))))
      (if has-permission
          (begin
              (map-set access-log {user: user} {block: stacks-block-height, allowed: true})
              (ok true)
          )
          (begin
              (map-set access-log {user: user} {block: stacks-block-height, allowed: false})
              (err u403)
          ))))
)

;; --------------------------------------------
;; Admin: Manually grant access
;; --------------------------------------------
(define-public (admin-grant-access (target principal))
  (begin
    (if (is-eq tx-sender admin)
      (begin
        (map-set access-log {user: target} {block: stacks-block-height, allowed: true})
        (ok true)
      )
      (err u401)
    )
  )
)

;; --------------------------------------------
;; Read-only: View access log for user
;; --------------------------------------------
(define-read-only (get-access-log (user principal))
  (map-get? access-log {user: user})
)
