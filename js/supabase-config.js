// Configuração pública do Supabase (seguro no navegador — a RLS protege os dados).
// A chave "publishable/anon" é feita para ficar no front-end.
window.SUPA = {
  url: 'https://ojhulerxocgaxbiutrnm.supabase.co',
  key: 'sb_publishable_ymBZmTMvyknOU-BGQedvsw_71XAPfoS',
  // CPF (só dígitos) vira um e-mail interno para o login do Supabase Auth
  emailDomain: 'paciente.clinicamedicinahumana.com.br',
  // Login do admin (usuário) também vira e-mail interno
  adminEmailDomain: 'admin.clinicamedicinahumana.com.br',
  // Médico entra por CRM (normalizado) -> e-mail interno
  medicoEmailDomain: 'medico.clinicamedicinahumana.com.br',
  // Nome da Edge Function publicada (o slug ficou "swift-api" no deploy)
  functionName: 'swift-api',
  // Envio do formulário da Ouvidoria por e-mail.
  // Atenção: o painel mostra o nome "ouvidoria", mas o slug do deploy
  // ficou "rapid-function" — é o slug que vale na URL.
  ouvidoriaFunction: 'rapid-function'
};
