function npmst --wraps='npm run dev' --wraps='pnpm run dev' --description 'alias npmst=pnpm run dev'
  pnpm run dev $argv
        
end
