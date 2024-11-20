SELECT 
  1800000000000000001::numeric / (10^18)::numeric AS truncated, -- truncates to 16 digits after decimal point
  1800000000000000001::numeric(48,18) / (10^18)::numeric AS correct,
  1800000000000000001::numeric / (10^18)::numeric * (10^18)::numeric AS to_be_sure;
