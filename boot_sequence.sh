# Boot Sequence

pubkey=EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

# boot_sequence:
# - op: system.setcode
#   label: Setting eosio.bios code for account eosio
#   data:
#     account: eosio
#     contract_name_ref: eosio.bios

cleos set contract /contracts/eosio.bios -p eosio

# - op: system.newaccount
#   label: Create account eosio.msig
#   data:
#     creator: eosio
#     new_account: eosio.msig
#     pubkey: ephemeral

cleos create account eosio eosio.msig $pubkey $pubkey

# - op: system.newaccount
#   label: Create account eosio.token
#   data:
#     creator: eosio
#     new_account: eosio.token
#     pubkey: ephemeral

cleos create account eosio eosio.token $pubkey $pubkey

# - op: system.newaccount
#   label: Create account eosio.disco
#   data:
#     creator: eosio
#     new_account: eosio.disco
#     pubkey: ephemeral

cleos create account eosio eosio.disco $pubkey $pubkey

# - op: system.newaccount
#   label: Create account eosio.unregd
#   data:
#     creator: eosio
#     new_account: eosio.unregd
#     pubkey: ephemeral

cleos create account eosio eosio.unregd $pubkey $pubkey

# - op: system.setpriv
#   label: Setting privileged account for eosio and eosio.msig
#   data:
#     account: eosio

cleos push action eosio setpriv '["eosio",1]' -p eosio

# - op: system.setpriv
#   label: Setting privileged account for eosio.msig
#   data:
#     account: eosio.msig

cleos push action eosio setpriv '["eosio.msig",1]' -p eosio

# - op: system.setcode
#   label: Setting eosio.msig code for account eosio.msig
#   data:
#     account: eosio.msig
#     contract_name_ref: eosio.msig

cleos set contract eosio.msig /contracts/eosio.msig -p eosio.msig

# - op: system.setcode
#   label: Setting eosio.token code for account eosio.token
#   data:
#     account: eosio.token
#     contract_name_ref: eosio.token

cleos set contract eosio.token /contracts/eosio.token -p eosio.token

# - op: system.setcode
#   label: Setting eosio.disco code for account eosio.disco
#   data:
#     account: eosio.disco
#     contract_name_ref: eosio.disco

cleos set contract eosio.disco /contracts/eosio.disco -p eosio.disco

# - op: system.setcode
#   label: Setting eosio.unregd code for account eosio.unregd
#   data:
#     account: eosio.unregd
#     contract_name_ref: eosio.unregd

cleos set contract eosio.unregd /contracts/eosio.unregd -p eosio.unregd

# - op: token.create
#   label: Creating the EOS currency symbol
#   data:
#     account: eosio
#     amount: 10000000000.0000 EOS  # Should work with 5% inflation, for the next 50 years (end of uint32 block_num anyway)
#     can_whitelist: false
#     can_freeze: false
#     can_recall: false

cleos push action eosio.token create '["eosio","10000000000.0000 EOS",0,0,0]' -p eosio.token

# - op: token.issue
#   label: Issuing initial EOS monetary base
#   data:
#     account: eosio
#     amount: 1000000000.0000 EOS  # 1B coins, as per distribution model.
#     memo: "Initial issuance"

cleos push action eosio.token issue '["eosio","1000000000.0000 EOS","Initial issuance"]' -p eosio

# - op: system.setcode
#   label: Replacing eosio account from eosio.bios contract to eosio.system
#   data:
#     account: eosio
#     contract_name_ref: eosio.system

cleos set contract eosio /contracts/eosio.system -p eosio

# - op: system.setram
#   label: Set initial RAM available
#   data:
#     max_ram_size: 25769803776  # 24 GB

# - op: producers.create_accounts
#   label: Creating initial Block Producers accounts
#   data:
#     TESTNET_ENRICH_PRODUCERS: true

# - op: snapshot.create_accounts
#   label: Creating accounts for ERC-20 holders
#   data:
#     buy_ram_bytes: 8192
#     TESTNET_TRUNCATE_SNAPSHOT: 50

# - op: snapshot.transfer
#   label: Injecting ERC-20 snapshot balances
#   data:
#     TESTNET_TRUNCATE_SNAPSHOT: 50

# - op: snapshot.load_unregistered
#   label: Saving unregistered addresses in eosio.unregd account, for the future.
#   data:
#     TESTNET_TRUNCATE_SNAPSHOT: 50

# - op: system.setprods
#   label: Setting the initial Appointed Block Producer schedule

# # - op: producers.register
# #   label: Register all producers with their declared key, URL and location

# - op: system.destroy_accounts
#   label: Disabling authorization for system accounts
#   data:
#     accounts:
#     #- eosio
#     - eosio.msig
#     - eosio.token
#     - eosio.disco
#     - eosio.unregd
