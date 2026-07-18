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
  functionName: 'swift-api'
};
