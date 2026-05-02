sros-cert
========

Ansible playbook that inventories TLS certificate files on Nokia SR OS **classic CLI** nodes and prints each file’s **notAfter** expiry (or a clear error) on the Ansible controller.

What it does
------------

#. **Connect** to each host in inventory using ``network_cli`` and the Nokia SR OS classic collection (see ``hosts``).

#. **List** configured filesystem roots (default ``cf3:\``) by running ``file dir <root>`` on the router.

#. **Match** lines of that output with a regex so only plausible certificate filenames ending in ``.crt`` or ``.cert`` are kept; paths are normalized (e.g. ``cf3:/name.crt``).

#. **For each path**, run ``file type <path>`` so the CLI prints the file contents. The playbook takes the **first PEM block** between ``-----BEGIN CERTIFICATE-----`` and ``-----END CERTIFICATE-----`` from that output.

#. **Parse** that PEM on **localhost** with ``openssl x509 -noout -enddate`` (stdin), so expiry is computed on your machine, not on the router.

#. **Emit** one ``debug`` message per file: JSON with ``filesystem_path``, whether the CLI read succeeded, whether a PEM block was found, and ``not_after`` (OpenSSL’s ``notAfter=`` line, an OpenSSL error string, or a note if no PEM was found).

No certificates are written to the devices; this is **read-only** inspection plus local OpenSSL.

Run
---

Install collections from repo root::

   ansible-galaxy collection install -r collections/requirements.yaml

From repo root::

   ansible-playbook -i sros-cert/hosts sros-cert/pb.readcert.yaml

From this directory::

   ansible-playbook -i hosts pb.readcert.yaml

Files
-----

``hosts``
   Inventory: ``ansible_network_os=nokia.sros.classic``, credentials, SSH options.

``pb.readcert.yaml``
   Playbook; adjust ``cert_search_roots`` / ``cert_file_regex`` if needed.

``tasks/read_one_cert.yaml``
   Included once per matched certificate path.

``lab-root-ca.*``, ``segw.*``
   Lab CA / CSR / cert samples; treat keys as secrets.
