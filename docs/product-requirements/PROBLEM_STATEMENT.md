# Problem statement

Source: [Foundation Specification v1.0](TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
sections 1-2. Status: planned product requirements; no product behavior implemented.
The owner [approved the initial foundation on 2026-11-10](../decisions/2026-11-10-foundation-approval.md).
All 17 open decisions and implementation approvals remain pending.

## Problem and intended users

A traveller may depend on a family member or assistant to research flights and
hotels, arrange payment, and support the trip. Recommendations alone do not
provide current inventory, explain conditions, establish purchase authority,
confirm supplier reservations, or handle disruptions. The motivating example is
someone arranging a mother's travel, not permission to handle personal funds/data.

The initial audience is individual travellers, family organizers, and authorized
assistants. Business travellers, managers, finance approvers, support teams, and
authorized agencies are later possibilities.

| Role | Responsibility |
| --- | --- |
| Traveller | Travels and supplies permitted details/preferences |
| Requester / organizer | Initiates and prepares arrangements |
| Approver | Authorizes a concrete, scoped proposal or purchase |
| Payer | Funds through an authorized mechanism |
| Operations / reviewer | Handles exceptions under narrowly scoped permissions |

One person may hold several roles, but authority must follow authenticated
identity, ownership, and explicit delegation. Invitation, acceptance, expiry,
revocation, payer authority, and exact permissions require further security design.

## Goals and staged scope

1. Research and compare sourced flights/accommodations; capture trip requirements,
   constraints, dates, budget, and traveller counts. Use explicit mocks first.
2. Present source/offer identifiers, timestamps, currency, fees, availability,
   baggage/cancellation terms where supported; separate facts from estimates.
   Prepare itineraries and preserve drafts, checkpoints, and feedback.
3. Support delegated plan review and proposals specifying exact offers, parties,
   totals, currency, conditions, and expiry. Significant changes require renewed
   review. Define model/tool quality and costs through measured evaluations.
4. Later, execute approved purchases through deterministic services, refresh
   prices/availability, track independent supplier and payment state, reconcile
   uncertain or partial outcomes, and verify ticket/hotel confirmations.
5. Later, support monitoring, disruption alerts, approved changes/refunds,
   rebooking research, support, and manual exception handling.

| Release | Intended outcome | Gate / constraint |
| --- | --- | --- |
| First usable research release | Authenticated requests, verified or clearly mocked offers, itineraries, delegated reviews, safe checkout previews/redirects where available | No unapproved purchase or direct-ticketing claim; exact MVP/metrics remain OPEN-15 |
| Controlled transaction release | Authorized supplier bookings, payments, independent confirmations, reconciliation/refunds | Partner access, sandbox tests, security and operational acceptance before live funds |
| Expanded operations | Monitoring, supported changes, corporate policies, support/rebooking | Supplier capability, cost, and verification gates per capability |

## Boundaries

AI recommends and prepares; deterministic business/security services control
consequential actions. The product is not authorized to purchase autonomously,
process real passports/money in early development, or claim supplier access.
Do not build an airline distribution system or payment processor from scratch.
Every logical responsibility need not become a separate agent, MCP server, or
microservice; every proposed technology need not run in the first prototype.

Markets, currencies, jurisdictions, supplier contracts, payment sequencing,
compliance, retention/deletion rules, and release metrics remain unresolved in
the specification's section 14 and [known limitations](../limitations/KNOWN_LIMITATIONS.md).
